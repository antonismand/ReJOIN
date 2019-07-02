from moz_sql_parser import parse
import json
import re


class StateVector:

    def __init__(self, query):

        self.query = query

        self.query_ast = json.dumps(parse(query))
        #print(self.query_ast)
        self.tree_structure = self.extract_tree_structure()
        self.join_predicates = self.extract_join_predicates()
        self.selection_predicates = self.extract_selection_predicates()

    def extract_tree_structure(self):
        #diagonal nxn
        return None

    def extract_join_predicates(self):
        pattern = re.compile(r'(\w+)(?:\.\w+ = )(\w+)')
        results = re.findall(pattern, self.query)

        tables = ['aka_name', 'aka_title', 'cast_info', 'char_name', 'comp_cast_type', 'company_name', 'company_type',
                  'complete_cast', 'info_type', 'keyword',
                  'kind_type', 'link_type', 'movie_companies', 'movie_info', 'movie_info_idx', 'movie_keyword',
                  'movie_link', 'name', 'person_info', 'role_type', 'title']

        aliases = {}
        for v in parse(self.query)['from']:
            aliases[v['name']] = tables.index(v['value'])

        results = []
        for v in parse(self.query)['where']['and']:
            if 'eq' in v and isinstance(v['eq'][1], str):
                results.append((v['eq'][0].split('.')[0],v['eq'][1].split('.')[0]))

        tables_num = len(tables)
        graph = [[0 for x in range(tables_num)] for y in range(tables_num)]

        for t1, t2 in results:
            graph[aliases[t1]][aliases[t2]] = 1
            graph[aliases[t2]][aliases[t1]] = 1
        return graph

    def extract_selection_predicates(self):

        return None