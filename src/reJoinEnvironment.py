from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

from tensorforce.environments import Environment
from src.database import Database
from src.state import StateVector

import numpy as np
import os


class ReJoin(Environment):

    def __init__(self, dataset, tables, attributes):

        self.tables = tables
        self.attributes = attributes
        self.dataset = dataset
        self.episode = 0
        self.file_names = os.listdir(dataset)
        filename = self.file_names[self.episode]
        file = open(dataset + "/" + filename, 'r')
        self.query = file.read()
        state = StateVector(self.query, self.tables, self.attributes)
        print(state.join_predicates)
        print(state.selection_predicates)
        # print(query)
        # print(db.get_query_time(query))

    def __str__(self):
        return ""

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
        self.episode = self.episode + 1
        filename = self.file_names[self.episode]
        file = open(self.dataset + "/" + filename, 'r')
        self.query = file.read()
        state = StateVector(self.query, self.tables, self.attributes)
        print(state.join_predicates)
        print(state.selection_predicates)

        return state

    def execute(self, action):

        """
        Executes action, observes next state(s) and reward.

        Args:
            actions: Actions to execute.

        Returns:
            Tuple of (next state, bool indicating terminal, reward)
        """

        # Get reward and process terminal & next state.
        terminal = self.is_terminal
        next_state = self.get_next_state(action)

        if terminal:
            reward = self.get_reward(next_state)
        else:
            reward = 0

        return next_state, terminal, reward

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

        return dict(shape=(self.tables, self.tables), type=int)

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

        return dict(type='int', shape=(2,), num_actions=self.tables*self.tables)

    @property
    def get_next_state(self, action):

        states = self.observation_space[0]
        s = self._join(states[action[0]], states[action[1]])
        del states[max(action[0], action[1])]
        del states[min(action[0], action[1])]
        states.append(s)
        raise NotImplementedError


    @property
    def is_terminal(self):
        raise NotImplementedError

    def get_reward(self, final_state):
        # """Reward is given for the final state."""
        #
        # explitic_joins_query = create_query(final_state)
        # if self.is_final:
        #     return 1 / Database.get_reward(explitic_joins_query, self.action_episode_memory, self.phase)
        # else:
        #     return 0.0
        raise NotImplementedError

    def create_query(self, final_state):

        """
        param: next_state
        returns: query with explicit join ordering selections
        """
        # Gonna use old query self.query and the join ordering as described by final_state

        raise NotImplementedError


    # def _join(self, s1, s2):
    #     # 0 1 0 0 0
    #     # 0 0 1 0 0
    #     result = [0] * self.TABLES
    #     for i in range(0, self.TABLES):
    #         if s1[i] != 0:
    #             result[i] = s1[i] / 2
    #         elif s2[i] != 0:
    #             result[i] = s2[i] / 2
    #     return result
    #     # 0 1/2 1/2 0 0
    #
    # def _action_space(self):
    #     jp = self.observation_space[1]
    #     states = self.observation_space[0]
    #     action_space = []
    #     for i in range(0, len(states)):
    #         for j in range(i + 1, len(states)):
    #             for idx1, val1 in enumerate(states[i]):
    #                 for idx2, val2 in enumerate(states[j]):
    #                     if val1 != 0 and val2 != 0 and jp[idx1][idx2] == 1:
    #                         action_space.append((i, j))
    #
    #     return action_space
