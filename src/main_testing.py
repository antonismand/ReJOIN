import os
from src.state import StateVector
from src.database import Database
import sys


"""
A "main" created for testing purposes

"""

tables = ["A", "B", "C", "D", "E"]

action_pairs = [[0, 1], [1, 2], [0, 1], [0, 1]]
join_ordering = tables
for action_pair in action_pairs:
    print("Join:", join_ordering[action_pair[0]], "⟕", join_ordering[action_pair[1]])
    join_ordering[action_pair[0]] = [
        join_ordering[action_pair[0]],
        join_ordering[action_pair[1]],
    ]
    del join_ordering[action_pair[1]]
    # print(tables)


db = Database()

query = db.construct_query([], [], join_ordering[0])

print("\n\n")
print(query)


# db = Database()
# dataset = "../join-order-benchmark/queries"
# tables, attributes = db.get_tables_attributes()
# cwd = os.getcwd()
# files = os.listdir(os.path.join(cwd, *dataset.split("/")))

# for file_name in files:
# file = open(dataset + "/" + file_name, "r")
# query = file.read()
# state_vector = StateVector(query, tables, attributes)
# print("\n")
# print(query)
# print("\n")
# print(state_vector.print_state())
# joins = [(12, 20), (6, 12), (2, 20), (2, 12), (2, 3), (2, 19), (5, 12)]
# aliases = state_vector.aliases
# query = db.construct_query(query, aliases, joins)
# print(query)
# break

# db.close()
