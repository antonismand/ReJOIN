import argparse
import logging
import os
from src.state import *
from src.database import *


def make_args_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dataset', default='../join-order-benchmark/queries',
                        help='Define the relative path of the dataset directory')

    return parser.parse_args()


def print_config(args):
    print("Running with the following configuration")
    arg_map = vars(args)
    for key in arg_map:
        print('\t', key, '->', arg_map[key])


def main():
    args = make_args_parser()
    print_config(args)

    db = Database()
    row = db.get_tables_attributes()

    tables_attributes = {}
    for table, attribute in row:
        if table in tables_attributes:
            tables_attributes[table].append(attribute)
        else:
            tables_attributes[table] = [attribute]

    tables = list(tables_attributes.keys())
    # print(tables)
    attributes = []
    for k in tables_attributes:
        attributes = attributes + [k + "." + v for v in tables_attributes[k]]
    # print(attributes)

    files = os.listdir(args.dataset)
    for file_name in files:
        file = open(args.dataset + "/" + file_name, 'r')

        query = file.read()

        initial_state = StateVector(query, tables, attributes)
        print(initial_state.join_predicates)
        print(initial_state.selection_predicates)

        # print(query)
        # print(db.get_query_time(query))
        break

    db.close()

    # drl_model = Model()
    # drl_model.train(dataset, hyperparameters)
    # drl_model.save()


if __name__ == '__main__':
    main()
