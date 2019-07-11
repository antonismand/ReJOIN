from moz_sql_parser import parse
import numpy as np
import pprint


class StateVector:
    def __init__(self, query, tables, attributes):

        self.query = query
        self.tables = tables
        self.attributes = attributes
        self.query_ast = parse(query)
        self.join_num = 0

        self.aliases = {}
        for v in self.query_ast["from"]:
            self.aliases[v["name"]] = (
                self.tables.index(v["value"]),
                v["value"],
            )  # {'alias' : (0,'table name')}

        self.original_names_to_aliases = {}
        for n in self.aliases:
            self.original_names_to_aliases[self.aliases[n][1]] = n

        self.joined_attrs = {}
        self.query_tables = set()
        self.alias_to_tables = {}
        for alias in self.aliases:
            self.alias_to_tables[alias] = [alias]

        self.tree_structure = self.extract_tree_structure()
        self.join_predicates = self.extract_join_predicates()
        self.selection_predicates = self.extract_selection_predicates()

        self.pp = pprint.PrettyPrinter(indent=2)

    def extract_tree_structure(self):
        # Initial State is a diagonal rxr matrix
        results = []
        for v in self.query_ast["where"]["and"]:
            if (
                    "eq" in v
                    and isinstance(v["eq"][0], str)
                    and isinstance(v["eq"][1], str)
            ):
                table_left = v["eq"][0].split(".")[0]
                table_right = v["eq"][1].split(".")[0]
                attr1 = v["eq"][0].split(".")[1]
                attr2 = v["eq"][1].split(".")[1]

                self.joined_attrs[(table_left, table_right)] = (attr1, attr2)
                self.joined_attrs[(table_right, table_left)] = (attr2, attr1)
                self.query_tables.update([table_left, table_right])

                results.append((table_left, table_right))

        tables_num = len(self.tables)
        graph = [[0 for x in range(tables_num)] for y in range(tables_num)]

        for t1, t2 in results:
            graph[self.aliases[t1][0]][self.aliases[t1][0]] = 1
            graph[self.aliases[t2][0]][self.aliases[t2][0]] = 1

        return graph

    def extract_join_predicates(self):

        results = []
        for v in self.query_ast["where"]["and"]:
            if (
                "eq" in v
                and isinstance(v["eq"][0], str)
                and isinstance(v["eq"][1], str)
            ):
                results.append((v["eq"][0].split(".")[0], v["eq"][1].split(".")[0]))

        tables_num = len(self.tables)
        graph = [[0 for x in range(tables_num)] for y in range(tables_num)]

        for t1, t2 in results:
            graph[self.aliases[t1][0]][self.aliases[t2][0]] = 1
            graph[self.aliases[t2][0]][self.aliases[t1][0]] = 1
            self.join_num += 1
        return graph

    def extract_selection_predicates(self):

        results = []
        attrs_num = len(self.attributes)

        for v in self.query_ast["where"]["and"]:
            for k in v:
                if k in {"eq", "neq", "le", "ge"}:  # examine queries to cover all cases
                    for i in range(2):
                        if isinstance(v[k][i], str):
                            table = v[k][i].split(".")[0]
                            attr = v[k][i].split(".")[1]
                            results.append(self.aliases[table][1] + "." + attr)

        join_predicate_vector = [0 for x in range(attrs_num)]
        # print(attrs_num)
        for x in results:
            join_predicate_vector[self.attributes.index(x)] = 1

        return np.array(join_predicate_vector)

    def vectorize(self):
        states = dict()
        states["tree_structure"] = self.tree_structure
        states["join_predicates"] = self.join_predicates
        states["selection_predicates"] = self.selection_predicates
        return states

    def convert_join_ordering_to_alias(self, join_ordering):
        for i in range(2):
            if isinstance(join_ordering[i], str):
                join_ordering[i] = self.original_names_to_aliases[join_ordering[i]]
            else:
                self.convert_join_ordering_to_alias(join_ordering[i])

    def print_state(self):             # Print for debugging
        print("\nTree-Structure:\n")
        print(np.array(self.tree_structure))
        print(np.array(self.tree_structure).shape)
        print("\nJoin-Predicates:\n")
        print(np.array(self.join_predicates))
        print(np.array(self.join_predicates).shape)
        print("\nSelection-Predicates:\n")
        print(np.array(self.selection_predicates))
        print(np.array(self.selection_predicates).shape)

    def print_joined_attrs(self):
        self.pp.pprint(self.joined_attrs)

    def print_query_tables(self):
        self.pp.pprint(self.query_tables)

    def print_query(self):
        self.pp.pprint(self.query_ast)

    def print_aliases(self):
        self.pp.pprint(self.aliases)

    def print_alias_to_tables(self):
        self.pp.pprint(self.alias_to_tables)

    def print_original_names_to_aliases(self):
        self.pp.pprint(self.original_names_to_aliases)