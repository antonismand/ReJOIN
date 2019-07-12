from src.database import Database
from src.state import StateVector
from moz_sql_parser import parse
import pprint

"""
A "main" created for testing purposes
"""

# [[ci,akt], an]
query = "SELECT ci.id AS id FROM cast_info AS ci, aka_title AS akt, aka_name AS an " \
        "WHERE ci.movie_id=akt.movie_id AND ci.person_id=an.person_id LIMIT 5;"

# query = '''
# SELECT MIN(mc.note) AS production_note,
#        MIN(t.title) AS movie_title,
#        MIN(t.production_year) AS movie_year
# FROM company_type AS ct,
#      info_type AS it,
#      movie_companies AS mc,
#      movie_info_idx AS mi_idx,
#      title AS t
# WHERE ct.kind = 'production companies'
#   AND it.info = 'top 250 rank'
#   AND mc.note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%'
#   AND (mc.note LIKE '%(co-production)%'
#        OR mc.note LIKE '%(presents)%')
#   AND ct.id = mc.company_type_id
#   AND t.id = mc.movie_id
#   AND t.id = mi_idx.movie_id
#   AND mc.movie_id = mi_idx.movie_id
#   AND it.id = mi_idx.info_type_id;
# '''

pp = pprint.PrettyPrinter(indent=2)

db = Database()
state_vector = StateVector(query, db.tables, db.attributes)

# -------------- Printing Messages Monitoring States -------------- #
print("\n\n------------------------\nParsed Query:\n")
state_vector.print_query()
print("------------------------------------------\n\n")
print("------------------------\nDatabase Tables:\n")
pp.pprint(db.tables)
print("------------------------------------------\n\n")
print("------------------------\nTables & Attributes:\n")
db.print_tables_attrs()
print("------------------------------------------\n\n")
print("------------------------\nQuery Joined Attrs:\n")
state_vector.print_joined_attrs()
print("------------------------------------------\n\n")
print("------------------------\nQuery Tables:\n")
state_vector.print_query_tables()
print("------------------------------------------\n\n")
print("------------------------\nTable Aliases:\n")
state_vector.print_aliases()
print("------------------------------------------\n\n")
print("------------------------\nOriginal Names to Aliases:\n")
state_vector.print_original_names_to_aliases()
print("------------------------------------------\n\n")
print("------------------------\nAlias-To-Tables:\n")
state_vector.print_alias_to_tables()
print("------------------------------------------\n\n")
# ----------------------------------------------------------------- #

# Actions followed by the agent
action_pairs = [[2, 1], [0, 1]]     # Specify a deep left join ordering

print("\n\nSpecify a Join Ordering:")
join_ordering = db.tables.copy()
tmp = zip(range(len(db.tables)), join_ordering)
for i in tmp:
    print(i)
final_ordering = []

for action_pair in action_pairs:
    print("\nJoin:", join_ordering[action_pair[0]], "⟕", join_ordering[action_pair[1]])

    join_ordering[action_pair[0]] = [
        join_ordering[action_pair[0]],
        join_ordering[action_pair[1]],
    ]
    del join_ordering[action_pair[1]]

    tmp = zip(range(len(db.tables)), join_ordering)
    for i in tmp:
        print(i)

    final_ordering = join_ordering[action_pair[0]]    # Is it (min(action_pair[0], action_pair[1])]) ?

print("\n\nFinal Join Ordering: ", final_ordering)
state_vector.convert_join_ordering_to_alias(final_ordering)
print("Final Join Ordering with Aliases: ", final_ordering)

# Test Query Reconstruction
# - feed a join-ordering and expect as return a fully constructed sql-query
# - containing those explicit join-orderings


print("\n\n\n\n------------------------\nConstructing the query...\n")
constructed_query = db.construct_query(state_vector.query_ast, final_ordering, db.tables_attributes, state_vector.joined_attrs,
                                       state_vector.alias_to_tables, state_vector.aliases)

# constructed_query_ast = parse(constructed_query)
# pp.pprint(constructed_query_ast)

pp.pprint(constructed_query)
print("------------------------------------------\n\n")


# # Names of the tables that are ***contained*** in the query

# tables = ["A", "B", "C", "D"]
#
# # Query-Tables and their attributes
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
