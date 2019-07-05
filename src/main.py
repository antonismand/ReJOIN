from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from tensorforce import TensorForceError
from tensorforce.agents import Agent
from tensorforce.execution import Runner
from src.reJoinEnv import ReJoin
from src.ReJoinEnvironment import ReJOINEnv
import argparse
import logging
import sys
import time
import json
import os
from src.state import *
from src.database import *
import csv


def make_args_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dataset', default='../join-order-benchmark/queries',
                        help='Define the relative path of the dataset directory')
    parser.add_argument('-a', '--agent-config', help="Agent configuration file")
    parser.add_argument('-n', '--network-spec', default=None, help="Network specification file")
    parser.add_argument('-rap', '--repeat-action-probability', help="Repeat action probability", type=float,
                        default=0.0)
    parser.add_argument('-e', '--episodes', type=int, default=50000, help="Number of episodes")
    parser.add_argument('-t', '--max-timesteps', type=int, default=2000, help="Maximum number of timesteps per episode")
    parser.add_argument('-s', '--save', help="Save agent to this dir")
    parser.add_argument('-se', '--save-episodes', type=int, default=100, help="Save agent every x episodes")
    parser.add_argument('-l', '--load', help="Load agent from this dir")
    parser.add_argument('-p', '--phase', help="Select phase (1 or 2)", default=1)

    return parser.parse_args()


def print_config(args):
    print("Running with the following configuration")
    arg_map = vars(args)
    for key in arg_map:
        print('\t', key, '->', arg_map[key])


def get_times():
    args = make_args_parser()
    db = Database()
    files = os.listdir(args.dataset)
    results = []
    for file_name in files:
        file = open(args.dataset + "/" + file_name, 'r')
        query = file.read()

        planning, execution = db.get_query_time(query)
        cost = db.optimizer_cost(query)
        results.append((file_name, planning, execution, cost))
        print(file_name, "Planning time:", planning, "Execution time:", execution, 'Cost:', cost)

        with open('times.csv', 'w', newline='') as out:
            csv_out = csv.writer(out)
            csv_out.writerow(['query', 'planning', 'execution', 'cost'])
            for row in results:
                csv_out.writerow(row)
        # break


def main():
    args = make_args_parser()
    # print_config(args)

    logger = logging.getLogger(__name__)
    logger.setLevel(logging.DEBUG)  # configurable!!!
    logger.addHandler(logging.StreamHandler(sys.stdout))

    # Connect to database
    db = Database()
    # get_times()

    # ~~~~~~~~~~~~~~~~~ Setting up the Model ~~~~~~~~~~~~~~~~~ #

    # Initialize environment (openAI or tensorforce)
    environment = ReJoin(args.dataset, db, args.phase)
    # environment = ReJOINEnv(args.dataset, tables, attributes)

    if args.agent_config is not None:
        with open(args.agent_config, 'r') as fp:
            agent_config = json.load(fp=fp)
    else:
        raise TensorForceError("No agent configuration provided.")

    network_spec = [
        dict(type='dense', size=128, activation='relu'),
        dict(type='dense', size=128, activation='relu')
    ]

    # Set up the PPO Agent
    agent = Agent.from_spec(
        spec=agent_config,
        kwargs=dict(
            states=environment.states,
            actions=environment.actions,
            network=network_spec
        )
    )

    runner = Runner(agent=agent, environment=environment)

    # ~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~ #

    report_episodes = 10

    def episode_finished(r):
        if r.episode % report_episodes == 0:
            sps = r.timestep / (time.time() - r.start_time)
            logger.info(
                "Finished episode {ep} after {ts} timesteps. Steps Per Second {sps}".format(ep=r.episode, ts=r.timestep,
                                                                                            sps=sps))
            logger.info("Episode reward: {}".format(r.episode_rewards[-1]))
            logger.info("Average of last 500 rewards: {}".format(sum(r.episode_rewards[-500:]) / 500))
            logger.info("Average of last 100 rewards: {}".format(sum(r.episode_rewards[-100:]) / 100))
        return True

    logger.info("Starting {agent} for Environment '{env}'".format(agent=agent, env=environment))

    # Start Training
    runner.run(args.episodes, args.max_timesteps, episode_finished=episode_finished)
    runner.close()
    logger.info("Learning finished. Total episodes: {ep}".format(ep=runner.episode))

    environment.close()

    db.close()


# def action_space():
#     #jp = self.observation_space[1]
#     #states = self.observation_space[0]
#     jp = [
#         [0, 0, 1, 0],
#         [0, 0, 1, 1],
#         [1, 1, 0, 0],
#         [0, 1, 0, 0],
#     ]
#     states = [
#         [1/2, 0, 1/2, 0],
#         [0, 1, 0, 0],
#         [0, 0, 0, 1],
#         #[0, 0, 0, 1],
#     ]
#     action_space = []
#     for i in range(0, len(states)):
#         for j in range(i + 1, len(states)):
#             for idx1, val1 in enumerate(states[i]):
#                 for idx2, val2 in enumerate(states[j]):
#                     if val1 != 0 and val2 != 0 and jp[idx1][idx2] == 1:
#                         action_space.append((i, j))
#
#     print(action_space)
#     return True


if __name__ == '__main__':
    main()
