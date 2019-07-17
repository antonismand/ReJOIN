from src.database import Database
from src.state import StateVector
import json
import os

db = Database()
cursor = db.conn.cursor()
q = """
CREATE TABLE queries (
        id SERIAL PRIMARY KEY,
        file_name VARCHAR(10) NOT NULL,
        query TEXT NOT NULL,
        moz JSON NOT NULL,
        planning REAL,
        execution REAL,
        cost REAL
)
"""
cursor.execute(q)
cursor.close()
db.conn.commit()

dataset = "join-order-benchmark/queries"
cwd = os.getcwd()
files = os.listdir(os.path.join(cwd, *dataset.split("/")))

cursor = db.conn.cursor()
for file_name in files:
    file = open(dataset + "/" + file_name, "r")
    query = file.read()
    ast = StateVector(query, db.tables, db.attributes).query_ast
    planning, execution = db.get_query_time(query)
    cost = db.optimizer_cost(query)
    print(file_name, planning, execution, cost)
    cursor.execute(
        "INSERT INTO queries (file_name, query, moz, planning, execution, cost) VALUES(%s, %s, %s, %s, %s, %s)",
        (file_name, query, json.dumps(ast), planning, execution, cost),
    )
    # break

db.conn.commit()
cursor.close()
