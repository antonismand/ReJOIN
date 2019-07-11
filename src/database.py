import psycopg2
import database_env as creds

from moz_sql_parser import parse
import pprint


class Database:
    def __init__(self):
        self.conn = self.connect()
        self.counter = 0
        self.aiases = {}

        self.tables_attributes = self.get_tables_attributes()
        self.tables = list(self.tables_attributes.keys())
        self.attributes = []
        for k in self.tables_attributes:
            self.attributes = self.attributes + [k + "." + v for v in self.tables_attributes[k]]

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

        return tables_attributes

    def print_tables_attrs(self):
        pp = pprint.PrettyPrinter(indent=2)
        pp.pprint(self.tables_attributes)

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

    def construct_query1(self, query, aliases, joins):
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

    def construct_query(self, query, join_ordering, attrs, joined_attrs, alias_to_tables):

        # Mapping relations/subtrees to their aliases
        # E.g. ['A']  -> "J1"
        #      ['B']  -> "J1"
        #      ['J1'] -> "J2"

        print(join_ordering)
        subq, alias = self.recursive_construct(join_ordering, attrs, joined_attrs, alias_to_tables)

        query = "SELECT ... FROM " + subq + " WHERE "

        return query

    def recursive_construct(self, subtree, attrs, joined_attrs, alias_to_tables):

        if isinstance(subtree, str):
            return subtree, subtree

        left, left_alias = self.recursive_construct(subtree[0], attrs, joined_attrs, alias_to_tables)
        right, right_alias = self.recursive_construct(subtree[1], attrs, joined_attrs, alias_to_tables)

        new_alias = "J" + str(self.counter)
        self.counter += 1

        print("\n\nAliases to tables: ")
        self.print_dict(alias_to_tables)
        alias_to_tables[new_alias] = [left_alias, right_alias]

        print("\n\nJoining subtrees: " + left_alias + " ⟕ " + right_alias)

        attr1, attr2 = joined_attrs[(left_alias, right_alias)]
        print("\n\nJoined Attrs: ")
        self.print_dict(joined_attrs)
        print("Attrs: " + attr1 + " , " + attr2)

        clause = self.select_clause(alias_to_tables, left_alias, right_alias, attrs)

        subquery = (
            "( SELECT "
            + clause
            + " FROM "
            + left
            + " JOIN "
            + right
            + " on "
            + left_alias
            + "."
            + attr1
            + " = "
            + right_alias
            + "."
            + attr2
            + ") "
            + new_alias
        )

        self.update_joined_attrs((left_alias, right_alias), new_alias, joined_attrs)
        print("\n\nUpdated Joined Attrs: ")
        self.print_dict(joined_attrs)

        print(subquery)

        return subquery, new_alias

    def update_joined_attrs(self, old_pair, new_alias, joined_attrs):           # Optimize this maybe

        # Delete the two elements corresponding to the subtrees we joined  e.g. [A,B]->[id, id2], [B,A]->[id2, id]
        del joined_attrs[(old_pair[0], old_pair[1])]
        del joined_attrs[(old_pair[1], old_pair[0])]

        # Search for other entries with values from the old pair and update their name
        for (t1, t2) in joined_attrs:

            (rel1, attr1) = (t1, joined_attrs[(t1, t2)][0])
            (rel2, attr2) = (t2, joined_attrs[(t1, t2)][1])

            if t1 == old_pair[0] or t1 == old_pair[1]:
                rel1 = new_alias
                attr1 = t1 + "_" + attr1

            if t2 == old_pair[0] or t2 == old_pair[1]:
                rel2 = new_alias
                attr2 = t2 + "_" + attr2

            if t1 != rel1 or t2 != rel2:
                del joined_attrs[(t1, t2)]
                joined_attrs[(rel1, rel2)] = (attr1, attr2)

    def select_clause(self, alias_to_tables, left_alias, right_alias, attrs):

        # print("\n\nSelect Clause:\n")

        clause = []
        tables_left = alias_to_tables[left_alias]
        tables_right = alias_to_tables[right_alias]

        # print(tables_left)
        # print(tables_right)
        self.recursive_select_clause(clause, left_alias + "_", alias_to_tables, left_alias, attrs, left_alias)
        self.recursive_select_clause(clause, right_alias + "_", alias_to_tables, right_alias, attrs, right_alias)

        select_clause = ""
        for i in range(len(clause)-1):
            select_clause += clause[i] + ", "
        select_clause += clause[len(clause)-1]
        # print(select_clause)

        return select_clause

    def recursive_select_clause(self, clause, path, alias_to_tables, alias, attrs, base_alias):

        # print(alias)

        rels = alias_to_tables[alias]
        if len(rels) > 1:
            for rel in rels:
                path1 = path + rel + "_"
                self.recursive_select_clause(clause, path1, alias_to_tables, rel, attrs, base_alias)
        else:
            attributes = attrs[rels[0]]
            for attr in attributes:
                clause.append(base_alias + "." + attr + " AS " + path + attr)

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

    def print_dict(self, d):
        for key in d:
            print(str(key) + " -> " + str(d[key]))
        print("\n")
