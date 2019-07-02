from moz_sql_parser import parse
import json


class StateVector:

    def __init__(self, query, tables):

        self.query = query
        self.tables = tables
        self.query_ast = json.dumps(parse(query))
        # print(self.query_ast)
        self.tree_structure = self.extract_tree_structure()
        self.join_predicates = self.extract_join_predicates()
        self.selection_predicates = self.extract_selection_predicates()

    def extract_tree_structure(self):
        # diagonal nxn
        return None

    def extract_join_predicates(self):
        aliases = {}
        for v in parse(self.query)['from']:
            aliases[v['name']] = self.tables.index(v['value'])

        results = []
        for v in parse(self.query)['where']['and']:
            if 'eq' in v and isinstance(v['eq'][1], str):
                results.append((v['eq'][0].split('.')[0], v['eq'][1].split('.')[0]))

        tables_num = len(self.tables)
        graph = [[0 for x in range(tables_num)] for y in range(tables_num)]

        for t1, t2 in results:
            graph[aliases[t1]][aliases[t2]] = 1
            graph[aliases[t2]][aliases[t1]] = 1
        return graph

    def extract_selection_predicates(self):

        return None
