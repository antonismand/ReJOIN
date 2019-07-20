from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

from tensorforce.environments import Environment
from src.state import StateVector
from src.database import Database

import numpy as np
import pprint
import math


class ReJoin(Environment):
    def __init__(
        self,
        phase,
        query_to_run,
        total_episodes,
        total_groups,
        memory,
        mode,
        target_group,
        run_all
    ):
        self.query_to_run = query_to_run
        self.pp = pprint.PrettyPrinter(indent=2)

        self.database = Database(collect_db_info=True)
        self.relations = self.database.relations
        self.num_relations = len(self.database.relations)

        self.attributes = self.database.attributes
        self.num_attrs = len(self.database.attributes)

        self.phase = phase

        self.episode_curr = 0
        self.step_curr = 0
        self.memory_actions = []
        self.memory = memory

        self.query = None
        self.state_vector = None
        self.state = None

        self.running_groups = total_groups != 0
        if total_groups != 0:
            self.it = 0
            self.mode = mode
            self.query_group = None
            self.target_group = target_group
            self.group_size = None
            self.total_episodes = total_episodes
            self.total_groups_size = self.database.get_groups_size(
                target=self.target_group, num_of_groups=total_groups
            )
            self.episodes_per_query = None
            self.episodes_per_group = int(total_episodes / total_groups)
            self.query_generator = self.database.get_queries_incremental(
                target=self.target_group
            )
            print("Mode:", self.mode)

        self.running_all = run_all
        if self.running_all:
            self.query_generator = self.database.get_queries_incremental_all()

    def __str__(self):
        return "ReJOIN"

    @property
    def states(self):
        """
        Return the state space. Might include subdicts if multiple states are
        available simultaneously.

        Returns:
            States specification, with the following attributes
                (required):
                - type: one of 'bool', 'int', 'float' (default: 'float').
                - shape: integer, or list/tuple of integers (required).
        """

        states = dict()
        states["tree_structure"] = dict(
            shape=(self.num_relations * self.num_relations), type="float"
        )
        states["join_predicates"] = dict(
            shape=(self.num_relations * self.num_relations), type="float"
        )
        states["selection_predicates"] = dict(shape=self.num_attrs, type="float")
        return states

    @property
    def actions(self):

        """
        Return the action space. Might include subdicts if multiple actions are
        available simultaneously.

        Returns:
            actions (spec, or dict of specs): Actions specification, with the following attributes
                (required):
                - type: one of 'bool', 'int', 'float' (required).
                - shape: integer, or list/tuple of integers (default: []).
                - num_actions: integer (required if type == 'int').
                - min_value and max_value: float (optional if type == 'float', default: none).
        """
        return dict(
            type="int",
            num_actions=47,
            # int((self.num_relations * self.num_relations - self.num_relations) / 2),
        )

    def is_terminal(self, possible_actions_len):
        return possible_actions_len == 0

    def close(self):
        print("Close")

    def seed(self, seed):
        """
        Sets the random seed of the environment to the given value (current time, if seed=None).
        Naturally deterministic Environments (e.g. ALE or some gym Envs) don't have to implement this method.
        Args:
            seed (int): The seed to use for initializing the pseudo-random number generator (default=epoch time in sec).
        Returns: The actual seed (int) used OR None if Environment did not override this method (no seeding supported).
        """
        return np.random.RandomState(seed)

    def reset(self):
        """
        Reset environment and setup for new episode.
        Returns:
            initial state of reset environment.
        """

        # Create a new initial state

        if self.query_to_run != "":
            self.query = self.database.get_query_by_filename(self.query_to_run)

        # Incremental learning - training groups
        elif self.running_groups:
            if self.episode_curr % self.episodes_per_group == 0:  # Group is over
                self.query_group = next(self.query_generator, None)  # Read next group
                self.it = 0
                self.group_size = len(self.query_group)

                # self.memory_rewards = [0]  # Re-set mean,std

                # Number of group episodes is proportional to number of queries in the group
                p = self.group_size / self.total_groups_size
                print("Total Group size: ", self.total_groups_size)
                print("P: ", p)
                self.episodes_per_group = int(p * self.total_episodes)
                print("Eps per group: ", self.episodes_per_group)

                self.episodes_per_query = int(self.episodes_per_group / self.group_size)
                # print(self.episodes_per_query)
                if self.query_group is None:  # If groups are over start again
                    self.query_generator = self.database.get_queries_incremental(
                        target=self.target_group
                    )
                    self.query_group = next(self.query_generator, None)
                    self.group_size = len(self.query_group)
                    p = self.group_size / self.total_groups_size
                    self.episodes_per_group = int(p * self.total_episodes)

            # <Episodes per group> iterations
            if self.mode == "round":
                # 1) round robbins [1a,2a,3a, 1a,2a,3a,...]
                self.query = self.query_group[self.it]
                self.it = (self.it + 1) % self.group_size

            elif self.mode == "sequential":
                # 2) sequentially [1a,1a,1a,..,2a,2a,2a,..,3a,3a,3a,..]
                self.query = self.query_group[self.it]
                if self.episodes_per_query == 0:
                    self.it = (self.it + 1) % self.group_size
                    self.episodes_per_query = int(
                        self.episodes_per_group / self.group_size
                    )
                self.episodes_per_query -= 1

            # print(self.query)

            eps = ""
            if self.mode == "sequential":
                eps = (
                    str(self.episodes_per_query)
                    + "/"
                    + str(int(self.episodes_per_group / self.group_size))
                )
            print(
                "Group: " + str(int(self.query["relations_num"])),
                ",  File Name: " + self.query["file"],
                ", ",
                eps,
            )

        # Ordering queries by increasing number of joins
        elif self.running_all:
            self.query = next(self.query_generator, None)  # Read next query
            if self.query is None:
                self.query_generator = self.database.get_queries_incremental_all()
                self.query = next(self.query_generator, None)
            print("File Name: " + self.query["file"])

        else:
            self.query = self.database.get_query_by_filename("1a")
        self.episode_curr += 1

        if self.query["file"] not in self.memory:
            self.memory[self.query["file"]] = {}
            self.memory[self.query["file"]]["rewards"] = [0]
            self.memory[self.query["file"]]["costs"] = []
            self.memory[self.query["file"]]["postgres_cost"] = self.query["cost"]

        self.state_vector = StateVector(
            self.query, self.database.tables, self.relations, self.attributes
        )
        self.state = self.state_vector.vectorize()
        self.memory_actions = []
        self.step_curr = 0

        # self.pp.pprint(self.state_vector.query_ast)
        return self.state

    def execute(self, action):
        """
        Executes action, observes next state(s) and reward.

        Args:
            action: Action to execute.

        Returns:
            Tuple of (next state, bool indicating terminal, reward)
        """

        # Re-shape in order to manipulate the state
        self.state["join_predicates"] = self.state["join_predicates"].reshape(
            self.num_relations, self.num_relations
        )
        self.state["tree_structure"] = self.state["tree_structure"].reshape(
            self.num_relations, self.num_relations
        )

        self.step_curr += 1
        # print("Step:", self.step_curr)

        # Get reward and process terminal & next state.
        possible_actions = self._get_valid_actions()  # [(0,1), (1,0), (1,2), (2,1)]
        # print("Possible actions", possible_actions)

        terminal = self.is_terminal(len(possible_actions))

        # self.pp.pprint(self.state["tree_structure"])

        if terminal:
            final_ordering = self._get_final_ordering()
            # print("Final Ordering:", final_ordering)
            reward = self.get_reward(final_ordering)
        else:
            reward = 0

            print("Action:", action)
            action = action % len(possible_actions)  # workaround hack
            action_pair = possible_actions[action]
            # print("State dependent-action (mod):", action)
            # print("Chose pair:", action_pair)

            self._set_next_state(action_pair)
            self.memory_actions.append(action_pair)
            # print("Memory_Actions:", self.memory_actions)

        self.state["join_predicates"] = self.state["join_predicates"].flatten()
        self.state["tree_structure"] = self.state["tree_structure"].flatten()

        return self.state, terminal, reward

    def get_reward(self, final_ordering):
        """Reward is given for the final state."""

        constructed_query = self.database.construct_query(
            self.state_vector.query_ast,
            final_ordering,
            self.database.relations_attributes,
            self.state_vector.joined_attrs,
            self.state_vector.alias_to_relations,
            self.state_vector.aliases,
        )
        cost = self.database.get_reward(constructed_query, self.phase)
        self.memory[self.query["file"]]["costs"].append(cost)
        reward = 1 / cost * 100000
        # reward **= 2
        # reward = math.exp(reward)
        # print(self.memory_costs)

        r = np.array(self.memory[self.query["file"]]["rewards"])
        mean = r.mean()
        std = r.std()
        print("Mean: ", mean, " Std: ", std)
        reward = (reward - mean) / (std + 0.1)

        self.memory[self.query["file"]]["rewards"].append(reward)
        print("Cost: ", round(cost))
        return reward

    def _get_valid_actions(self):

        jp = self.state["join_predicates"]
        states = self.state["tree_structure"]
        actions = []

        for i in range(0, self.num_relations):
            for j in range(i + 1, self.num_relations):

                for idx1, val1 in enumerate(states[i]):
                    for idx2, val2 in enumerate(states[j]):
                        if (
                            val1 != 0
                            and val2 != 0
                            and jp[idx1][idx2] == 1
                            and (i, j) not in actions
                        ):
                            actions.append((i, j))
                            # actions.append((j, i))
        return actions

    def _set_next_state(self, action):

        np.set_printoptions(linewidth=150)
        # print("Current State:\n")
        # print(self.state["tree_structure"])
        # print(self.state["tree_structure"].shape)

        states = self.state["tree_structure"]
        self._join_subtrees(states[action[0]], states[action[1]])
        states = np.delete(states, action[1], 0)
        padding = [0] * self.num_relations
        states = np.vstack((states, [padding]))
        self.state["tree_structure"] = states

        # print("Next State:\n")
        #
        # print(self.state["tree_structure"])
        # print(self.state["tree_structure"].shape)

    def _join_subtrees(self, s1, s2):

        # [0  1  0  0  0] JOIN
        # [0  0  1  0  0] =
        # [0 .5 .5  0  0]

        for i in range(0, self.num_relations):
            if s1[i] != 0:
                s1[i] = s1[i] / 2
            elif s2[i] != 0:
                s1[i] = s2[i] / 2

    def _get_final_ordering(self):

        join_ordering = self.database.relations.copy()
        # tmp = zip(range(self.num_relations), join_ordering)
        # for i in tmp:
        #     print(i)
        final_ordering = []

        for action_pair in self.memory_actions:
            # print(
            #     "\nJoin:",
            #     join_ordering[action_pair[0]],
            #     "⟕",
            #     join_ordering[action_pair[1]],
            # )

            join_ordering[action_pair[0]] = [
                join_ordering[action_pair[0]],
                join_ordering[action_pair[1]],
            ]

            final_ordering = join_ordering[action_pair[0]]

            del join_ordering[action_pair[1]]

            # tmp = zip(range(self.num_relations), join_ordering)
            # for i in tmp:
            #     print(i)

        # print("\n\nFinal Join Ordering: ", final_ordering)
        return final_ordering
