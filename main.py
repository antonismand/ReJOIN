from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

from tensorforce import TensorForceError
from tensorforce.agents import Agent
from tensorforce.execution import Runner
from src.environment import ReJoin
from src.database import Database
from tensorforce.agents import PPOAgent
import matplotlib.pyplot as plt
import numpy as np

# from src.distribution import CustomCategorical

import argparse
import logging
import sys
import time
import os
import json

# sys.argv = [""]


def make_args_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-a",
        "--agent-config",
        default="config/ppo.json",
        help="Agent configuration file",
    )
    parser.add_argument(
        "-n",
        "--network-spec",
        default="config/mlp2-network.json",
        help="Network specification file",
    )
    parser.add_argument(
        "-rap",
        "--repeat-action-probability",
        help="Repeat action probability",
        type=float,
        default=0.0,
    )
    parser.add_argument(
        "-e", "--episodes", type=int, default=400, help="Number of episodes"
    )
    parser.add_argument(
        "-g",
        "--groups",
        type=int,
        default=1,
        help="Total groups of different number of relations",
    )
    parser.add_argument("-m", "--mode", type=str, default="round", help="Incremental Mode")
    parser.add_argument(
        "-t",
        "--max-timesteps",
        type=int,
        default=20,
        help="Maximum number of timesteps per episode",
    )
    parser.add_argument("-q", "--query", default="", help="Run specific query")
    parser.add_argument("-s", "--save", help="Save agent to this dir")
    parser.add_argument(
        "-se",
        "--save-episodes",
        type=int,
        default=100,
        help="Save agent every x episodes",
    )
    parser.add_argument("-l", "--load", help="Load agent from this dir")
    parser.add_argument("-p", "--phase", help="Select phase (1 or 2)", default=1)

    return parser.parse_args()


def print_config(args):
    print("Running with the following configuration")
    arg_map = vars(args)
    for key in arg_map:
        print("\t", key, "->", arg_map[key])


def main():
    args = make_args_parser()
    # print_config(args)
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.DEBUG)
    logger.addHandler(logging.StreamHandler(sys.stdout))

    # Connect to database
    db = Database(collect_db_info=True)
    # get_times()

    # ~~~~~~~~~~~~~~~~~ Setting up the Model ~~~~~~~~~~~~~~~~~ #

    # Initialize environment (tensorforce's template)
    memory_costs = {}
    environment = ReJoin(db, args.phase, args.query, args.episodes, args.groups, memory_costs, args.mode)

    if args.agent_config is not None:
        with open(args.agent_config, "r") as fp:
            agent_config = json.load(fp=fp)
    else:
        raise TensorForceError("No agent configuration provided.")

    if args.network_spec is not None:
        with open(args.network_spec, "r") as fp:
            network_spec = json.load(fp=fp)
    else:
        raise TensorForceError("No network configuration provided.")

    dims = 128
    # dims1 = 1024
    # Todo: Pass this via JSON
    network_spec = [
        [
            dict(type="input", names=["tree_structure"]),
            # dict(type="flatten"),
            dict(type="dense", size=dims, activation="relu"),
            dict(type="output", name="tree_structure_emb"),
        ],
        [
            dict(type="input", names=["join_predicates"]),
            # dict(type="flatten"),
            dict(type="dense", size=dims, activation="relu"),
            dict(type="output", name="join_predicates_emb"),
        ],
        [
            dict(type="input", names=["selection_predicates"]),
            dict(type="dense", size=dims, activation="relu"),
            dict(type="output", name="selection_predicates_emb"),
        ],
        [
            dict(
                type="input",
                names=[
                    "tree_structure_emb",
                    "join_predicates_emb",
                    "selection_predicates_emb",
                ],
            ),
            dict(type="dense", size=dims, activation="relu"),
            dict(type="dense", size=dims, activation="relu"),
            # dict(type='dueling', size=3, activation='none'),
            dict(type="output", name="prediction"),
        ],
    ]

    # Set up the PPO Agent
    agent = PPOAgent(
        states=environment.states,
        actions=environment.actions,
        network=network_spec,
        step_optimizer=dict(type="adam", learning_rate=1e-3),
        update_mode=dict(units="episodes", batch_size=64, frequency=4),
        memory=dict(type='replay', include_next_states=False, capacity=10000),
        summarizer=dict(
            directory="./board",
            steps=50,
            labels=[
                "graph",
                "gradients_scalar",
                "regularization",
                "inputs",
                "losses",
                "variables"
            ]
        )

    )

    # agent = Agent.from_spec(
    #     spec=agent_config,
    #     kwargs=dict(
    #         states=environment.states, actions=environment.actions, network=network_spec
    #     ),
    # )

    runner = Runner(agent=agent, environment=environment)

    # ~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~ #

    report_episodes = 1

    def episode_finished(r):
        if r.episode % report_episodes == 0:
            # sps = r.timestep / (time.time() - r.start_time)
            # logger.info(
            #     "Finished episode {ep} after {ts} timesteps. Steps Per Second {sps}".format(
            #         ep=r.episode, ts=r.timestep, sps=sps
            #     )
            # )

            logger.info(
                "Episode {ep} reward: {r}".format(ep=r.episode, r=r.episode_rewards[-1])
            )
            # logger.info(
            #     "Average of last 500 rewards: {}".format(
            #         sum(r.episode_rewards[-500:]) / 500
            #     )
            # )
            logger.info(
                "Average of last 100 rewards: {}\n".format(
                    sum(r.episode_rewards[-100:]) / 100
                )
            )
        return True

    logger.info(
        "Starting {agent} for Environment '{env}'".format(agent=agent, env=environment)
    )

    # Start Training
    runner.run(
        episodes=args.episodes,
        max_episode_timesteps=args.max_timesteps,
        episode_finished=episode_finished,
    )

    runner.close()
    logger.info("Learning finished. Total episodes: {ep}".format(ep=runner.episode))

    # environment.close()
    # print(runner.episode_rewards)
    # print(len(runner.episode_rewards))
    def find_convergence(eps):
        last = eps[-1]
        for i in range(1, len(eps)):
            if eps[i * -1] != last:
                print("Converged at episode:", len(eps) - i + 2)
                return True

    find_convergence(runner.episode_rewards)
    plt.figure(1)
    plt.hist(runner.episode_rewards)

    plt.figure(2)
    plt.plot(runner.episode_rewards, "b.", MarkerSize=2)

    output_path = "./outputs/1group-400-round/"
    if not os.path.exists(output_path):
        os.makedirs(output_path)
    # Plot recorded costs over all episodes
    print(memory_costs)
    for i, key in enumerate(memory_costs):
        plt.figure(i+3)
        filename = key.split(".")[0]

        q = db.get_query_by_filename(filename)
        postgres_estimate = db.optimizer_cost(q["query"], force_order=False)
        costs = np.array(memory_costs[key])
        max_val = max(costs)
        min_val = min(costs)
        plt.xlabel("episode")
        plt.ylabel("cost")
        plt.title(filename)
        plt.scatter(np.arange(len(costs)), costs, c="g", alpha=0.5, marker=r'$\ast$',
                    label="Cost")
        plt.legend(loc='upper right')
        plt.scatter(0, [min_val], c="r", alpha=1, marker=r'$\heartsuit$', s=200,
                    label="min cost observed=" + str(min_val))
        plt.scatter(0, [max_val], c="b", alpha=1, marker=r'$\times$', s=200,
                    label="max cost observed=" + str(max_val))
        plt.legend(loc='upper right')
        plt.scatter(0, [postgres_estimate], c="c", alpha=1, marker=r'$\star$', s=200,
                    label="postgreSQL estimate=" + str(postgres_estimate))
        plt.legend(loc='upper right')

        plt.savefig(output_path + filename + '.png')

    plt.show(block=True)
    db.close()


if __name__ == "__main__":
    main()
