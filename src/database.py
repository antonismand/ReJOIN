import config.database as creds
import psycopg2
import pprint
import src.database_utils as utils


class Database:
    def __init__(self, collect_db_info):

        self.pp = pprint.PrettyPrinter(indent=2)

        self.conn = self.connect()
        self.counter = 0
        self.aliases = {}

        # Build database related info
        # - tables,
        # - relations (original-tables + aliases),
        # - {relation : attributes}
        # - attributes

        if collect_db_info:
            self.tables, self.relations, self.relations_attributes, self.relations_tables = (
                self.get_relations_attributes()
            )
            self.attributes = []
            for k in self.relations_attributes:
                self.attributes = self.attributes + [
                    k + "." + v for v in self.relations_attributes[k]
                ]

        # self.pp.pprint(self.relations)

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

    def get_relations_attributes(self):
        """
        Returns relations and their attributes

        Uses tables/attributes from the database but also aliases found on the dataset's queries

        Args:
            None
        Returns:
            relations: list ['alias1','alias2',..]
            relations_attributes: dict {'alias1':['attr1','attr2',..], .. }

        """
        cursor = self.conn.cursor()
        q = (
            "SELECT c.table_name, c.column_name FROM information_schema.columns c "
            "INNER JOIN information_schema.tables t ON c.table_name = t.table_name "
            "AND c.table_schema = t.table_schema "
            "AND t.table_type = 'BASE TABLE' "
            "AND t.table_schema = 'public' "
            "AND c.table_name != 'queries'"
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
        relations_attributes = {}
        relations = []
        relations_tables = {}
        x = self.get_queries_incremental(target="")
        for group in x:
            for q in group:
                for r in q["moz"]["from"]:
                    if r["name"] not in relations:
                        relations.append(r["name"])
                        relations_attributes[r["name"]] = tables_attributes[r["value"]]
                        relations_tables[r["name"]] = r["value"]
        return tables, relations, relations_attributes, relations_tables

    def print_relations_attrs(self):
        pp = pprint.PrettyPrinter(indent=2)
        pp.pprint(self.relations_attributes)

    def get_query_by_id(self, id):
        cursor = self.conn.cursor()
        q = "SELECT * FROM queries WHERE id = %s"
        cursor.execute(q, (str(id),))
        rows = cursor.fetchone()
        cursor.close()
        attrs = [
            "id",
            "file",
            "relations_num",
            "query",
            "moz",
            "planning",
            "execution",
            "cost",
        ]
        zipbObj = zip(attrs, rows)
        return dict(zipbObj)

    def get_query_by_filename(self, file):
        file = file + ".sql"
        cursor = self.conn.cursor()
        q = "SELECT * FROM queries WHERE file_name = %s"
        cursor.execute(q, (file,))
        rows = cursor.fetchone()
        cursor.close()
        attrs = [
            "id",
            "file",
            "relations_num",
            "query",
            "moz",
            "planning",
            "execution",
            "cost",
        ]
        zipbObj = zip(attrs, rows)
        return dict(zipbObj)

    def get_queries_incremental(self, target):
        cursor = self.conn.cursor()

        attrs = [
            "id",
            "file",
            "relations_num",
            "query",
            "moz",
            "planning",
            "execution",
            "cost",
        ]

        # Yield all groups one by one
        if target == "":
            q = "SELECT * FROM queries ORDER BY relations_num"
            cursor.execute(q)

        # Yield only one target group
        else:
            q = "SELECT * FROM queries WHERE relations_num=%s"
            cursor.execute(q, (str(target),))

        rows = cursor.fetchall()
        cursor.close()

        qs = {}
        for q in rows:
            q = dict(zip(attrs, q))
            num = q["relations_num"]
            if num not in qs:
                qs[num] = [q]
            else:
                qs[num].append(q)

        keys = list(qs.keys())
        keys.sort()
        for key in keys:
            yield qs[key]

        return None

    def get_groups_size(self, target, num_of_groups):

        cursor = self.conn.cursor()

        # Size of groups 1 to num_of_groups
        if target == "":
            q = (
                "select sum(count) from (select relations_num, count(*) "
                "as count from queries group by relations_num order by relations_num limit  %s) X"
            )
            cursor.execute(q, (str(num_of_groups),))

        # Size of a specific group
        else:
            q = (
                "select count(*) from queries where relations_num=%s"
            )
            cursor.execute(q, (str(target),))

        row = cursor.fetchone()
        cursor.close()
        return row[0]

    def get_queries_size(self):
        cursor = self.conn.cursor()
        q = "SELECT COUNT(*) FROM queries"
        cursor.execute(q, (str(id),))
        row = cursor.fetchone()
        cursor.close()
        return row[0]

    def close(self):
        if self.conn:
            self.conn.close()

    def optimizer_cost(self, query, force_order=False):
        join_collapse_limit = "SET join_collapse_limit = "
        join_collapse_limit += "1" if force_order else "8"
        query = join_collapse_limit + ";EXPLAIN (FORMAT JSON) " + query + ";"
        cursor = self.conn.cursor()
        cursor.execute(query)
        rows = cursor.fetchone()
        cursor.close()
        return rows[0][0]["Plan"]["Total Cost"]

    def get_query_time(self, query, force_order=False):
        join_collapse_limit = "SET join_collapse_limit = "
        join_collapse_limit += "1" if force_order else "8"
        query = join_collapse_limit + ";EXPLAIN ANALYZE " + query + ";"
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

    def construct_query(
        self, query_ast, join_ordering, attrs, joined_attrs, alias_to_relations, aliases
    ):

        relations_to_alias = {}

        # print(join_ordering)
        subq, alias = self.recursive_construct(
            join_ordering,
            attrs,
            joined_attrs,
            relations_to_alias,
            alias_to_relations,
            aliases,
        )

        select_clause = utils.get_select_clause(query_ast, relations_to_alias, alias)
        where_clause = utils.get_where_clause(query_ast, relations_to_alias, alias)

        limit = ""
        if "limit" in query_ast:
            limit = " LIMIT " + str(query_ast["limit"])

        # print("\n\nRelations to aliases: ")
        # self.print_dict(relations_to_alias)

        query = select_clause + " FROM " + subq + where_clause + limit

        # print(query)
        self.counter = 0
        return query

    def recursive_construct(
        self,
        subtree,
        attrs,
        joined_attrs,
        relations_to_alias,
        alias_to_relations,
        aliases,
    ):

        if isinstance(subtree, str):
            return subtree, subtree

        left, left_alias = self.recursive_construct(
            subtree[0],
            attrs,
            joined_attrs,
            relations_to_alias,
            alias_to_relations,
            aliases,
        )
        right, right_alias = self.recursive_construct(
            subtree[1],
            attrs,
            joined_attrs,
            relations_to_alias,
            alias_to_relations,
            aliases,
        )

        new_alias = "J" + str(self.counter)
        relations_to_alias[left_alias] = new_alias
        relations_to_alias[right_alias] = new_alias
        self.counter += 1

        # print("\n\nAliases to relations: ")
        alias_to_relations[new_alias] = [left_alias, right_alias]
        # self.print_dict(alias_to_relations)

        # print("\n\nJoining subtrees: " + left_alias + " ⟕ " + right_alias)

        attr1, attr2 = joined_attrs[(left_alias, right_alias)]
        # print("\n\nJoined Attrs: ")
        # self.print_dict(joined_attrs)
        # print("Attrs: " + attr1 + " , " + attr2)

        if left == left_alias:
            left = aliases[left] + " AS " + left
        if right == right_alias:
            right = aliases[right] + " AS " + right

        clause = self.select_clause(
            alias_to_relations, left_alias, right_alias, attrs, aliases
        )

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
        # print("\n\nUpdated Joined Attrs: ")
        # self.print_dict(joined_attrs)

        # print(subquery)

        return subquery, new_alias

    def update_joined_attrs(self, old_pair, new_alias, joined_attrs):
        # Optimize this maybe

        # Delete the two elements corresponding to the subtrees we joined
        # e.g. [A,B]->[id, id2], [B,A]->[id2, id]
        del joined_attrs[(old_pair[0], old_pair[1])]
        del joined_attrs[(old_pair[1], old_pair[0])]

        # Search for other entries with values from the old pair and update their name
        keys = list(joined_attrs.keys())
        for (t1, t2) in keys:

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

    def select_clause(
        self, alias_to_relations, left_alias, right_alias, attrs, aliases
    ):

        # print("\n\nSelect Clause:\n")

        clause = []
        # relations_left = alias_to_relations[left_alias] ; relations_right = alias_to_relations[right_alias]
        # print(relations_left); print(relations_right)

        self.recursive_select_clause(
            clause, "", alias_to_relations, left_alias, attrs, left_alias, aliases
        )
        self.recursive_select_clause(
            clause, "", alias_to_relations, right_alias, attrs, right_alias, aliases
        )

        select_clause = ""
        for i in range(len(clause) - 1):
            select_clause += clause[i] + ", "
        select_clause += clause[len(clause) - 1]
        # print(select_clause)

        return select_clause

    def recursive_select_clause(
        self, clause, path, alias_to_relations, alias, attrs, base_alias, aliases
    ):

        # print(alias)
        rels = alias_to_relations[alias]
        if len(rels) > 1:
            for rel in rels:
                path1 = path + rel + "_"
                self.recursive_select_clause(
                    clause, path1, alias_to_relations, rel, attrs, base_alias, aliases
                )
        else:
            attributes = attrs[rels[0]]
            for attr in attributes:
                tmp = path + attr
                clause.append(base_alias + "." + tmp + " AS " + base_alias + "_" + tmp)

    def get_reward(self, query, phase):
        if phase == 1:
            return self.optimizer_cost(query, True)  # Get Cost Model's Estimate
        return self.get_query_time(query, True)[1]  # Get actual query-execution latency

    def print_dict(self, d):
        for key in d:
            print(str(key) + " -> " + str(d[key]))
        print("\n")
