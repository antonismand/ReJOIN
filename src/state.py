from moz_sql_parser import parse
import json

class StateVector:

    def __init__(self, sql_query):

        self.query = sql_query

        self.query_ast = json.dumps(parse(sql_query))
        print(self.query_ast)
        self.tree_structure = self.extract_tree_structure()
        self.join_predicates = self.extract_join_predicates()
        self.selection_predicates = self.extract_selection_predicates()


    def extract_tree_structure(self, sql_query):

        return None

    def extract_join_predicates(self, sql_query):

        return None

    def extract_selection_predicates(self, sql_query):

        return None