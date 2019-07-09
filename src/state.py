from moz_sql_parser import parse
import numpy as np


class StateVector:
    def __init__(self, query, tables, attributes):

        self.query = query
        self.tables = tables
        self.attributes = attributes
        self.query_ast = parse(query)
        self.aliases = {}
        self.join_num = 0
        for v in self.query_ast["from"]:
            self.aliases[v["name"]] = (
                self.tables.index(v["value"]),
                v["value"],
            )  # {'alias' : (0,'table name')}

        print(self.query_ast)
        self.tree_structure = self.extract_tree_structure()
        self.join_predicates = self.extract_join_predicates()
        self.selection_predicates = self.extract_selection_predicates()

    def extract_tree_structure(self):
        # Initial State is a diagonal rxr matrix
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

