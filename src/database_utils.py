def get_alias(attr, tables_to_alias, alias):

    tmp = attr.split(".")
    relname = tmp[0]
    attrname = tmp[1]

    while relname in tables_to_alias:
        attrname = relname + "_" + attrname
        relname = tables_to_alias[relname]

    return alias + "." + attrname


def get_select_clause(query_ast, tables_to_alias, alias):

    # Construct SELECT clause

    select_operator_map = {
        "min": "MIN",
        "max": "MAX",
    }  # to be filled with other possible values

    select_stmt = query_ast["select"]
    select = []

    if not isinstance(select_stmt, (list,)):
        select_stmt = [select_stmt]

    for v in select_stmt:

        val = v["value"]
        name = ""

        if not isinstance(val, str):
            key = list(val.keys())[0]
            val = (
                select_operator_map[key]
                + "("
                + get_alias(val[key], tables_to_alias, alias)
                + ")"
            )
        else:
            val = get_alias(val, tables_to_alias, alias)

        if "name" in v:
            name = " AS " + v["name"]

        select.append((val, name))

    select_clause = "SELECT "
    for i in range(len(select) - 1):
        select_clause += select[i][0] + select[i][1] + ","
    select_clause += select[len(select) - 1][0] + select[len(select) - 1][1]

    # print(select_clause)
    return select_clause


def construct_stmt(stmt, operator_map, tables_to_alias, alias):

    # print(stmt)
    key = list(stmt.keys())[0]
    if key == "and" or key == "or":  # Need to go deeper
        return (
            "("
            + construct_stmt(stmt[key][0], operator_map, tables_to_alias, alias)
            + ") "
            + key.upper()
            + " ("
            + construct_stmt(stmt[key][1], operator_map, tables_to_alias, alias)
            + ")"
        )
    elif not isinstance(stmt[key][1], str):  # R-value is Dict (Literal)
        return (
            get_alias(stmt[key][0], tables_to_alias, alias)
            + " "
            + operator_map[key]
            + " "
            + "'"
            + stmt[key][1]["literal"]
            + "'"
        )
    else:
        return (
            get_alias(stmt[key][0], tables_to_alias, alias)
            + " "
            + operator_map[key]
            + " "
            + get_alias(stmt[key][1], tables_to_alias, alias)
        )


def get_where_clause(query_ast, tables_to_alias, alias):

    # Construct WHERE clause

    operator_map = {
        "eq": "=",
        "gt": ">",
        "lt": "<",
        "like": "LIKE",
        "nlike": "NOT LIKE",
        "in": "IN",
    }  # to be filled with other possible values

    where_stmt = query_ast["where"]["and"]
    where = []
    for v in where_stmt:
        if not (
            "eq" in v and isinstance(v["eq"][0], str) and isinstance(v["eq"][1], str)
        ):  # if not a joining
            where.append(construct_stmt(v, operator_map, tables_to_alias, alias))

    where_clause = ""
    if len(where) > 0:
        where_clause = " \nWHERE \n"
        for i in range(len(where) - 1):
            where_clause += where[i] + ",\n"
        where_clause += where[len(where) - 1]

    # print(where_clause)
    return where_clause
