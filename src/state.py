import numpy as np
import pprint
# import moz_sql_parser


class StateVector:
    def __init__(self, query, original_tables, relations, attributes):

        self.pp = pprint.PrettyPrinter(indent=2)

        self.query = query
        # print(query)
        self.original_tables = original_tables
        self.relations = relations
        self.attributes = attributes
        self.query_ast = query["moz"]  # moz_sql_parser.parse(query)

        self.aliases = {}
        for v in self.query_ast["from"]:
            self.aliases[v["name"]] = v["value"]

        # Help structures for query reconstruction
        self.joined_attrs = {}
        self.alias_to_relations = {}
        for alias in self.aliases:
            self.alias_to_relations[alias] = [alias]

        # State Representation (to be fed in the NN)
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
                table_left = v["eq"][0].split(".")[0]
                table_right = v["eq"][1].split(".")[0]
                attr1 = v["eq"][0].split(".")[1]
                attr2 = v["eq"][1].split(".")[1]

                self.joined_attrs[(table_left, table_right)] = (attr1, attr2)
                self.joined_attrs[(table_right, table_left)] = (attr2, attr1)

                results.append((table_left, table_right))

        relations_num = len(self.relations)
        graph = [[0 for x in range(relations_num)] for y in range(relations_num)]

        for t1, t2 in results:
            graph[self.relations.index(t1)][self.relations.index(t1)] = 1
            graph[self.relations.index(t2)][self.relations.index(t2)] = 1

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

        relations_num = len(self.relations)
        graph = [[0 for x in range(relations_num)] for y in range(relations_num)]

        for t1, t2 in results:
            graph[self.relations.index(t1)][self.relations.index(t2)] = 1
            graph[self.relations.index(t2)][self.relations.index(t1)] = 1
        return graph

    def extract_selection_predicates(self):

        results = []
        attrs_num = len(self.attributes)

        for v in self.query_ast["where"]["and"]:
            for k in v:
                if k in {"eq", "neq", "lt", "gt", "lte", "gte"}:  # examine queries to cover all cases
                    for i in range(2):
                        if isinstance(v[k][i], str):
                            relation = v[k][i].split(".")[0]
                            attr = v[k][i].split(".")[1]
                            results.append(relation + "." + attr)

        join_predicate_vector = [0 for x in range(attrs_num)]
        for x in results:
            join_predicate_vector[self.attributes.index(x)] = 1

        return np.array(join_predicate_vector)

    def vectorize(self):
        states = dict()
        states["tree_structure"] = np.array(self.tree_structure, dtype=float).flatten()
        states["join_predicates"] = np.array(self.join_predicates).flatten()
        states["selection_predicates"] = np.array(self.selection_predicates)

        return states

    def print_state(self):  # Print for debugging
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

    def print_query(self):
        self.pp.pprint(self.query_ast)

    def print_aliases(self):
        self.pp.pprint(self.aliases)

    def print_alias_to_relations(self):
        self.pp.pprint(self.alias_to_relations)

