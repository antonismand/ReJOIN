import psycopg2
import database_env as creds

from moz_sql_parser import parse


class Database:
    def __init__(self):
        self.conn = self.connect()
        self.tables, self.attributes = self.get_tables_attributes()

    def connect(self):
        try:
            conn_string = (
                "host="
                + creds.PGHOST
                + " port="
                + "5432"
                + " dbname="
                + creds.PGDATABASE
                + " user="
                + creds.PGUSER
                + " password="
                + creds.PGPASSWORD
            )
            conn = psycopg2.connect(conn_string)
            return conn
        except (Exception, psycopg2.Error) as error:
            print("Error connecting")

    def get_tables_attributes(self):
        cursor = self.conn.cursor()
        q = (
            "SELECT c.table_name, c.column_name FROM information_schema.columns c "
            "INNER JOIN information_schema.tables t ON c.table_name = t.table_name "
            "AND c.table_schema = t.table_schema "
            "AND t.table_type = 'BASE TABLE' "
            "AND t.table_schema = 'public'"
        )
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
        return rows[0][0][0]["Plan"]["Total Cost"]

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

    def construct_query(self, query, aliases, joins):
        query_moz = parse(query)
        join_map = {}  # [ (12, 20): ['t.id', 'mc.movie_id'] , ..]
        for v in query_moz["where"]["and"]:
            print(v)
            if (
                "eq" in v
                and isinstance(v["eq"][0], str)
                and isinstance(v["eq"][1], str)
            ):
                # join_map.append((v['eq'][0].split('.')[0], v['eq'][1].split('.')[0]))
                alias1 = v["eq"][0].split(".")[0]
                alias2 = v["eq"][1].split(".")[0]
                t1 = aliases[alias1][0]
                t2 = aliases[alias2][0]
                # print("alias:", alias1, "=", alias2, " Tables:", t1, "=", t2)
                join_map[(min(t1, t2), max(t1, t2))] = v["eq"]

        n = 0
        for v in query_moz["where"]["and"]:
            if (
                "eq" in v
                and isinstance(v["eq"][0], str)
                and isinstance(v["eq"][1], str)
            ):
                # query_moz["where"]["and"][k]['eq'] = join_map[joins[n]]
                replace = v["eq"][0] + " = " + v["eq"][1]
                joins[n]
                query = query.replace(
                    replace, "|" + "-JOIN-".join(str(i) for i in joins[n]) + "|"
                )
                n += 1
        for j in joins:
            replace = "|" + str(j[0]) + "-JOIN-" + str(j[1]) + "|"
            pred1 = join_map[j][0]
            pred2 = join_map[j][1]
            cond = pred1 + " = " + pred2
            query = query.replace(replace, cond)

        return query

    def get_reward(self, query, phase):
        # get reward from specific episode(tuples of joins)
        # query = query  # todo reorder query from tree
        if phase == 1:
            return self.optimizer_cost(query)
        return self.get_query_time(query)[1]

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
