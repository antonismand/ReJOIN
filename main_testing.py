from src.database import Database
from src.state import StateVector
from moz_sql_parser import parse
import pprint
import math
import numpy as np
import matplotlib.pyplot as plt
import os



# """
# A "main" created for testing purposes
# """
#
# # [[ci,at], an]
# query = "SELECT ci.id AS id FROM cast_info AS ci, aka_title AS at, aka_name AS an " \
#         "WHERE ci.movie_id=at.movie_id AND ci.person_id=an.person_id LIMIT 5;"
#
#
#
#
# # query = '''
# # SELECT MIN(cn.name) AS from_company,
# # FROM company_name AS cn,
# #      company_type AS ct,
# #      keyword AS k,
# #      movie_keyword AS mk,
# #      movie_link AS ml,
# #      title AS t
# # WHERE cn.country_code !='[pl]'
# #   AND ct.kind IS NOT NULL
# #   AND t.production_year > 1950
# #   AND ml.movie_id = t.id
# #   AND t.id = mk.movie_id;
# # '''
#
# # dataset = "./join-order-benchmark/queries"
# # cwd = os.getcwd()
# # files = os.listdir(os.path.join(cwd, *dataset.split("/")))
# pp = pprint.PrettyPrinter(indent=2)
# #
# # file = open(dataset + "/" + "7a.sql", "r")
# # query = file.read()
# # ast = parse(query)
# # pp.pprint(ast)
#
# db = Database(False)
# print("A")
# x = db.get_queries_incremental()
# for i in range(0, 50):
#     a = next(x, None)
#
#     if a is None:
#         x = db.get_queries_incremental()
#         a = next(x, None)
#
#         print(a)
#
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
