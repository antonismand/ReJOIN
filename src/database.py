import psycopg2
import database_env as creds

from moz_sql_parser import parse


class Database:

    def __init__(self):
        self.conn = self.connect()
        self.tables, self.attributes = self.get_tables_attributes()

    def connect(self):
        try:
            conn_string = "host=" + creds.PGHOST + " port=" + "5432" + " dbname=" + creds.PGDATABASE + " user=" + creds.PGUSER \
                          + " password=" + creds.PGPASSWORD
            conn = psycopg2.connect(conn_string)
            return conn
        except (Exception, psycopg2.Error) as error:
            print("Error connecting")

    def get_tables_attributes(self):
        cursor = self.conn.cursor()
        q = "SELECT c.table_name, c.column_name FROM information_schema.columns c " \
            "INNER JOIN information_schema.tables t ON c.table_name = t.table_name " \
            "AND c.table_schema = t.table_schema " \
            "AND t.table_type = 'BASE TABLE' " \
            "AND t.table_schema = 'public'"
        cursor.execute(q)
        rows = cursor.fetchall()
        cursor.close()

        tables_attributes = {}
        for table, attribute in rows:
            if table in tables_attributes:
                tables_attributes[table].append(attribute)
            else:
                tables_attributes[table] = [attribute]

        tables = list(tables_attributes.keys())
        attributes = []
        for k in tables_attributes:
            attributes = attributes + [k + "." + v for v in tables_attributes[k]]
        return tables, attributes

    def close(self):
        if self.conn:
            self.conn.close()

    def optimizer_cost(self, query):
        query = "EXPLAIN (FORMAT JSON) " + query
        cursor = self.conn.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
        cursor.close()
        return rows[0][0][0]['Plan']['Total Cost']

    def get_query_time(self, query):
        query = "EXPLAIN ANALYZE " + query
        cursor = self.conn.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
        planning = [float(s) for s in rows[-2][0].split() if self.is_number(s)]
        execution = [float(s) for s in rows[-1][0].split() if self.is_number(s)]
        cursor.close()
        return planning[0], execution[0]

    def is_number(self, s):
        try:
            float(s)
            return True
        except ValueError:
            return False

    def get_reward(self, query, phase):  # get reward from specific episode(tuples of joins)
        query = query  # todo reorder query from tree
        if phase == 1:
            return self.optimizer_cost(query)
        return self.get_query_time(query)[1]

    def construct_query(self, query, state_vector, history):  # query string , history = [(1,2),(2,4)]

        query_moz = parse(query)
        query = ""  # remove join conditions

        # "bla.id = xa.id" -> (0,1)
        # [(0,1) = 'bla.id = xa.id']

        aliases = state_vector.aliases  # {'alias' : (0,'table name')}

        query = ''  # append join condition 1 by 1
        joins = []
        tree = state_vector.tree_structure
        join_predicates = state_vector.join_predicates
        for pair in history:
            # (1,2)
            s1 = tree[pair[0]]
            s2 = tree[pair[1]]
            tables_s1, tables_s2 = []
            for k, t in enumerate(s1):
                if t != 0:
                    tables_s1.append(k)
            for k, t in enumerate(s2):
                if t != 0:
                    tables_s2.append(k)

            # [ 1/2  0  1/2  0] -> (0,2) A,C
            # [ 0  1  0  1] -> (1,4) B,D

            once = True
            for t in tables_s1:
                for t2 in tables_s2:
                    if join_predicates[t][t2] == 1 and once:
                        joins.append((t, t2))
                        once = False

            s = self._join(s1, s2)
            del tree[max(pair[0], pair[1])]
            del tree[min(pair[0], pair[1])]
            tree.append(s)
            tree.append([0] * len(self.tables))
        # [(1,3), (4,6)]        tables

        return query

    def _join(self, s1, s2):
        # 0 1 0 0 0
        # 0 0 1 0 0
        result = [0] * self.TABLES
        for i in range(0, self.TABLES):
            if s1[i] != 0:
                result[i] = s1[i] / 2
            elif s2[i] != 0:
                result[i] = s2[i] / 2
        return result
