import os
from src.state import StateVector
from src.database import Database


"""
A "main" created for testing purposes

"""
# import sys
# sys.argv = [""]
# del sys

dataset = "../join-order-benchmark/queries"
db = Database()
tables, attributes = db.get_tables_attributes()

cwd = os.getcwd()
files = os.listdir(os.path.join(cwd, *dataset.split("/")))

for file_name in files:
    file = open(dataset + "/" + file_name, "r")
    query = file.read()
    state_vector = StateVector(query, tables, attributes)
    print("\n")
    print(query)
    print("\n")
    print(state_vector.print_state())

    # joins = [(12, 20), (6, 12), (2, 20), (2, 12), (2, 3), (2, 19), (5, 12)]
    # aliases = state_vector.aliases
    # query = db.construct_query(query, aliases, joins)
    # print(query)

    break
db.close()


