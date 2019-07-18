from src.database import Database
import moz_sql_parser
import json
import os


def backup_queries():

    cmd = "pg_dump -h localhost -p 5432 -U postgres -W  --table='queries' " \
          "--data-only --column-inserts imdbload > queries.sql"
    try:
        os.system(cmd)
        print("Backup completed")
    except Exception as e:
        print("!!Problem occured!!")
        print(e)


db = Database(collect_db_info=False)

cursor = db.conn.cursor()
q = """
CREATE TABLE queries (
        id SERIAL PRIMARY KEY,
        file_name VARCHAR(10) NOT NULL,
        relations_num REAL,
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
    ast = moz_sql_parser.parse(query)
    relations_num = len(ast["from"])
    planning, execution = db.get_query_time(query)
    cost = db.optimizer_cost(query)
    print(file_name, relations_num, planning, execution, cost)
    cursor.execute(
        "INSERT INTO queries (file_name, relations_num, query, moz, planning, execution, cost) VALUES(%s, %s, %s, %s, %s, %s, %s)",
        (file_name, relations_num, query, json.dumps(ast), planning, execution, cost),
    )
    # break


backup_queries()
db.conn.commit()
cursor.close()
