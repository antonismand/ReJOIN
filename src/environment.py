from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

from tensorforce.environments import Environment
from src.state import StateVector

import numpy as np
import pprint


class ReJoin(Environment):
    def __init__(self, database, phase, query_to_run):
        self.query_to_run = query_to_run
        self.pp = pprint.PrettyPrinter(indent=2)

        self.database = database
        self.relations = database.relations
        self.num_relations = len(database.relations)

        self.attributes = database.attributes
        self.num_attrs = len(database.attributes)

        self.phase = phase

        self.episode_curr = 0
        self.step_curr = 0
        self.memory_actions = []

        self.query = None
        self.state_vector = None
        self.state = None

        self.query_generator = database.get_queries_incremental()

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
            type="int", num_actions=int((self.num_relations * self.num_relations - self.num_relations)/2)
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
        self.episode_curr += 1

        # # Incremental learning - ordering queries by increasing number of joins
        # self.query = next(self.query_generator, None)
        # if self.query is None:
        #     self.query_generator = self.database.get_queries_incremental()
        #     self.query = next(self.query_generator, None)

        # self.query = self.database.get_query_by_id(self.episode_curr)
        # self.query = self.database.get_query_by_id(1)
        self.query = self.database.get_query_by_filename("3a")
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

            print("Pre-action:", action)
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
        reward = 1 / cost * 1000000
        reward **= 2

        print("\nCost: ", round(cost))
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
