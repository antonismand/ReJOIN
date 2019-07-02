from moz_sql_parser import parse
import json

class State:

    def __init__(self, sql_query):

        self.query = sql_query
        self.initial_state = self.extract_initial_state(sql_query)

    def extract_initial_state(self, sql_query):

        ast = json.dumps(parse(sql_query))

        print(ast)

        return None

