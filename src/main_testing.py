import os
# from src.state import StateVector
from database import Database
import sys


"""
A "main" created for testing purposes

"""

# Things needed for query construction:

# Names of the tables that are ***contained*** in the query
tables = ["A", "B", "C", "D"]

# Query-Tables and their attributes - this can be in main since it
# does not change per query (all database tables)

attrs = {'A': ["id", "a1", "a2"],
         'B': ["id", "id2", "a2"],
         'C': ["id", "id2", "a2"],
         'D': ["id", "a1", "a2"]}

# Info about which tables get joined with which attributes (derived by the parsed_query)
joined_attrs = {
    ('A', 'B'): ('id', 'id'), ('B', 'A'): ('id', 'id'),
    ('C', 'B'): ('id', 'id2'), ('B', 'C'): ('id2', 'id'),
    ('C', 'D'): ('id2', 'id'), ('D', 'C'): ('id', 'id2')
}

# A map of aliases and the relations they refer to
alias_to_tables = {
    'A': ['A'],
    'B': ['B'],
    'C': ['C'],
    'D': ['D']
    # e.g. 'J1': {"A", "B"} etc
}

# Actions followed by the agent
action_pairs = [[0, 1], [0, 1], [0, 1]]

join_ordering = tables
for action_pair in action_pairs:
    # print("Join:", join_ordering[action_pair[0]], "⟕", join_ordering[action_pair[1]])
    join_ordering[action_pair[0]] = [
        join_ordering[action_pair[0]],
        join_ordering[action_pair[1]],
    ]
    del join_ordering[action_pair[1]]
    # print(tables)


db = Database()

query = db.construct_query([], join_ordering[0], attrs, joined_attrs, alias_to_tables)

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
