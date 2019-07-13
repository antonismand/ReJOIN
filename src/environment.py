from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

from tensorforce.environments import Environment
from src.state import StateVector

import numpy as np
import pprint
import os


class ReJoin(Environment):
    def __init__(self, dataset, database, phase):

        self.pp = pprint.PrettyPrinter(indent=2)

        self.dataset = dataset
        self.file_names = os.listdir(dataset)

        self.tables = database.tables
        self.num_tables = len(database.tables)

        self.attributes = database.attributes
        self.num_attrs = len(database.attributes)

        self.phase = phase

        self.episode_curr = 0
        self.step_curr = 0
        # self.memory_actions = []

        self.query = None
        self.state_vector = None
        self.join_num = None
        self.state = None

        # self.tables_joined = []
        self.join_ordering = self.tables.copy()

    def __str__(self):
        return "ReJOIN Environment"

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
        print("\n\nSEED\n\n")

        return np.random.RandomState(seed)

    def reset(self):
        """
        Reset environment and setup for new episode.
        Returns:
            initial state of reset environment.
        """

        print("\n\nRESET\n\n")

        # Create a new initial state
        # filename = self.file_names[self.episode_curr]
        # # filename = self.file_names[0]
        # file = open(self.dataset + "/" + filename, "r")
        # self.query = file.read()

        # [[ci,akt], an]
        self.query = "SELECT ci.id AS id FROM cast_info AS ci, aka_title AS akt, aka_name AS an " \
        "WHERE ci.movie_id=akt.movie_id AND ci.person_id=an.person_id LIMIT 5;"

        self.state_vector = StateVector(self.query, self.tables, self.attributes)
        self.join_num = self.state_vector.join_num
        self.state = self.state_vector.vectorize()
        # self.memory_actions = []
        self.episode_curr += 1

        self.join_ordering = self.tables.copy()

        self.pp.pprint(self.state_vector.query_ast)
        # print(state.join_predicates)
        # print(state.selection_predicates)
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
        self.state["join_predicates"] = self.state["join_predicates"].reshape(self.num_tables, self.num_tables)
        self.state["tree_structure"] = self.state["tree_structure"].reshape(self.num_tables, self.num_tables)

        print(self.state["join_predicates"].shape)
        print(self.state["tree_structure"].shape)

        self.step_curr += 1
        print("Step:", self.step_curr, " Join Num:", self.join_num)

        possible_actions = self._get_valid_actions()  # [(0,1), (1,0), (1,2), (2,1)]
        print("Possible actions", possible_actions)

        print("Pre-action:", action)
        action = action % len(possible_actions)  # workaround hack
        action_pair = possible_actions[action]
        print("State dependent-action (mod):", action)
        print("Chose pair:", action_pair)

        # Get reward and process terminal & next state.
        terminal = self.is_terminal

        self.pp.pprint(self.state["tree_structure"])
        self._set_next_state(action_pair)

        # self.memory_actions.append(action_pair)
        # print("Memory_Actions:", self.memory_actions)
        # # print(self.temp)

        print("\nJoin [", self.join_ordering[action_pair[0]], "⟕", self.join_ordering[action_pair[1]], "]\n")
        self.join_ordering[action_pair[0]] = [self.join_ordering[action_pair[0]], self.join_ordering[action_pair[1]]]
        del self.join_ordering[action_pair[1]]

        if terminal:
            reward = self.get_reward()
        else:
            reward = 0

        return self.state, terminal, reward

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
        states["tree_structure"] = dict(shape=(self.num_tables*self.num_tables), type="float")
        states["join_predicates"] = dict(shape=(self.num_tables*self.num_tables), type="float")
        states["selection_predicates"] = dict(shape=self.num_attrs, type="float")
        print(states)
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
        # Discrete value {1, 2,.., n} where n = (num_relations*num_relations)-num_relations
        return dict(
            type="int", num_actions=self.num_tables * self.num_tables
        )  # - self.num_tables ignore for now

    @property
    def is_terminal(self):
        return self.step_curr == self.join_num

    def get_reward(self):
        """Reward is given for the final state."""

        if self.is_final:
            new_query = self.database.construct_query(self.query, self.state_vector.aliases, self.join_ordering)
            return 1 / self.database.get_reward(new_query, self.phase)
        else:
            return 0.0

    def _get_valid_actions(self):

        jp = self.state["join_predicates"]
        states = self.state["tree_structure"]
        actions = []

        for i in range(0, self.num_tables):
            for j in range(i + 1, self.num_tables):

                for idx1, val1 in enumerate(states[i]):
                    for idx2, val2 in enumerate(states[j]):
                        if val1 != 0 and val2 != 0 and jp[idx1][idx2] == 1:
                            actions.append((i, j))
                            actions.append((j, i))  # ToDo:  Examine if this is redundant info during training
        return actions

    def _set_next_state(self, action):

        print("\n\nGET NEXT STATE\n\n")

        states = self.state["tree_structure"]
        s = self._join(states[action[0]], states[action[1]])
        states = np.delete(states, max(action[0], action[1]), 0)
        states = np.delete(states, min(action[0], action[1]), 0)
        padding = [0] * self.num_tables
        states = np.vstack((states, [s]))
        states = np.vstack((states, [padding]))
        # states.append([0] * self.num_tables)
        self.state["tree_structure"] = states

        print("Next State:\n")
        self.pp.pprint(self.state["tree_structure"])


    def _join(self, s1, s2):
        # 0 1 0 0 0
        # 0 0 1 0 0
        result = [0] * self.num_tables
        for i in range(0, self.num_tables):
            if s1[i] != 0:
                result[i] = s1[i] / 2
            elif s2[i] != 0:
                result[i] = s2[i] / 2
        return result
        # 0 1/2 1/2 0 0

