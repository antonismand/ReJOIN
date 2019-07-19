from src.database import Database
from src.state import StateVector
from moz_sql_parser import parse
import pprint

"""
A "main" created for testing purposes
"""

# [[ci,at], an]
query = (
    "SELECT ci.id AS id FROM cast_info AS ci, aka_title AS at, aka_name AS an "
    "WHERE ci.movie_id=at.movie_id AND ci.person_id=an.person_id LIMIT 5;"
)

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

db = Database(True)
# query = db.get_query_by_id(1)


state_vector = StateVector(query, db.tables, db.relations, db.attributes)

# -------------- Printing Messages Monitoring States -------------- #
print("\n\n------------------------\nParsed Query:\n")
state_vector.print_query()
print("------------------------------------------\n\n")
# print("------------------------\nDatabase Tables:\n")
# pp.pprint(db.tables)
# print("------------------------------------------\n\n")
# print("------------------------\nRelations & Attributes:\n")
# db.print_relations_attrs()
# print("------------------------------------------\n\n")
print("------------------------\nQuery Joined Attrs:\n")
state_vector.print_joined_attrs()
print("------------------------------------------\n\n")
# print("------------------------\nQuery Tables:\n")
# state_vector.print_query_tables()
# print("------------------------------------------\n\n")
print("------------------------\nRelation Aliases:\n")
state_vector.print_aliases()
print("------------------------------------------\n\n")
# print("------------------------\nOriginal Names to Aliases:\n")
# state_vector.print_original_names_to_aliases()
# print("------------------------------------------\n\n")
print("------------------------\nAlias-To-relations:\n")
state_vector.print_alias_to_relations()
print("------------------------------------------\n\n")
# ----------------------------------------------------------------- #

# Actions followed by the agent
action_pairs = [[1, 32], [1, 7]]

print("\n\nSpecify a Join Ordering:")
join_ordering = db.relations.copy()
tmp = zip(range(len(db.relations)), join_ordering)
for i in tmp:
    print(i)
final_ordering = []

for action_pair in action_pairs:
    print("\nJoin:", join_ordering[action_pair[0]], "⟕", join_ordering[action_pair[1]])

    join_ordering[action_pair[0]] = [
        join_ordering[action_pair[0]],
        join_ordering[action_pair[1]],
    ]

    final_ordering = join_ordering[action_pair[0]]

    del join_ordering[action_pair[1]]

    tmp = zip(range(len(db.relations)), join_ordering)
    for i in tmp:
        print(i)


print("\n\nFinal Join Ordering: ", final_ordering)

print("\n\n\n\n------------------------\nConstructing the query...\n")
constructed_query = db.construct_query(
    state_vector.query_ast,
    final_ordering,
    db.relations_attributes,
    state_vector.joined_attrs,
    state_vector.alias_to_relations,
    state_vector.aliases,
)

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


s = {}

s["aka_title"] = 1
s["char_name"] = 1
s["role_type"] = 1

s["comp_cast_type"] = 1
s["movie_link"] = 2
s["link_type"] = 1
s["cast_info"] = 4

s["complete_cast"] = 2
s["title"] = 9
s["aka_name"] = 2

s["movie_companies"] = 3
s["kind_type"] = 1
s["name"] = 2


s["company_type"] = 1
s["movie_keyword"] = 2
s["movie_info"] = 2
s["person_info"] = 2

s["company_name"] = 1
s["keyword"] = 1
s["movie_info_idx"] = 2
s["info_type"] = 3

c = 0
# for k, v in s.items():
#     c += v
for alias, table in db.relations_tables.items():
    c += s[table]
c /= 2
print("Total possible joins", c)
