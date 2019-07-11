from database import Database
from state import StateVector
import pprint
import os
import sys

"""
A "main" created for testing purposes

"""

# Things needed for query construction:

# query = "SELECT * " \
#         "FROM ((cast_info " \
#         "JOIN aka_title on cast_info.movie_id=aka_title.movie_id) " \
#         "JOIN aka_name on cast_info.person_id=aka_name.person_id) " \
#         "LIMIT 5;"

pp = pprint.PrettyPrinter(indent=2)

query = "SELECT * FROM cast_info AS ci, aka_title AS akt, aka_name AS an " \
        "WHERE ci.movie_id=akt.movie_id AND ci.person_id=an.person_id LIMIT 5;"

db = Database()
state_vector = StateVector(query, db.tables, db.attributes)

state_vector.print_query()
print("\n\nTables:\n")
pp.pprint(db.tables)
print("\n\nTables & Attributes:\n")
db.print_tables_attrs()
print("\n\nQuery Joined Attrs:\n")
state_vector.print_joined_attrs()
print("\n\nQuery Tables:\n")
state_vector.print_query_tables()






# # Names of the tables that are ***contained*** in the query
# tables = ["A", "B", "C", "D"]
#
# # Query-Tables and their attributes - this can be in main since it
# # does not change per query (all database tables)
#
# attrs = {'A': ["id", "a1", "a2"],
#          'B': ["id", "id2", "a2"],
#          'C': ["id", "id2", "a2"],
#          'D': ["id", "a1", "a2"]}
#
# # Info about which tables get joined with which attributes (derived by the parsed_query)
# joined_attrs = {
#     ('A', 'B'): ('id', 'id'), ('B', 'A'): ('id', 'id'),
#     ('C', 'B'): ('id', 'id2'), ('B', 'C'): ('id2', 'id'),
#     ('C', 'D'): ('id2', 'id'), ('D', 'C'): ('id', 'id2')
# }
#
# # A map of aliases and the relations they refer to
# alias_to_tables = {
#     'A': ['A'],
#     'B': ['B'],
#     'C': ['C'],
#     'D': ['D']
#     # e.g. 'J1': {"A", "B"} etc
# }
#
# # Actions followed by the agent
# action_pairs = [[0, 1], [0, 1], [0, 1]]
#
# join_ordering = tables
# for action_pair in action_pairs:
#     # print("Join:", join_ordering[action_pair[0]], "⟕", join_ordering[action_pair[1]])
#     join_ordering[action_pair[0]] = [
#         join_ordering[action_pair[0]],
#         join_ordering[action_pair[1]],
#     ]
#     del join_ordering[action_pair[1]]
#     # print(tables)
#
#
# db = Database()
#
# query = db.construct_query([], join_ordering[0], attrs, joined_attrs, alias_to_tables)
#
# print("\n\n")
# print(query)


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
