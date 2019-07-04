
"""
Rejoin Environment
"""

from src.database import Database
from src.state import StateVector
from gym import spaces
import numpy as np
import random
import gym
import os


class ReJOINEnv(gym.Env):
    """
    The environment defines which actions can be taken at which point and
    when the agent receives which reward.
    """

    def __init__(self, dataset, tables, attributes, phase):

        self.tables = tables
        self.tables_num = len(tables)
        self.attributes = attributes
        self.attrs_num = len(attributes)
        self.dataset = dataset

        self.curr_step = 0
        self.curr_episode = 0
        self.is_final = False
        self.phase = phase

        self.file_names = os.listdir(dataset)

        # Define action and observation spaces
        low = 0
        high = 1
        self.action_space = spaces.Tuple([spaces.Discrete(self.tables), spaces.Discrete(self.tables)])  # todo ?
        self.observation_space = spaces.Box(low=low, high=high, shape=(self.tables_num, self.tables_num), dtype=np.float32)    # TreeVector (for now use only this)

        # self.action_space = spaces.MultiDiscrete([(1, self.tables), (1, self.tables)])
        # self.observation_space = spaces.Tuple((
            # spaces.Box(low=low, high=high, shape=(self.tables_num, self.tables_num), dtype=np.float32),         # TreeVector
            # spaces.Box(low=low, high=high, shape=(self.tables_num, self.tables_num), dtype=np.float32),         # Join Predicates
            # spaces.Box(low, high, shape=(self.attrs_num,), dtype=np.uint8)                                    # Selection predicates
        # ))

        # high = np.array([1, ]
        # )
        # self.observation_space = spaces.Tuple((
        #     spaces.Box(low, high, dtype=np.float32),  # tree
        #     spaces.Box(np.array([0, ]), high, dtype=np.int),  # join predicates
        #     spaces.Box(np.array([0, ]), high, dtype=np.int)  # todo fix this selection predicates
        # ))

        # Read first query
        self.curr_query = self.read_next_query(self.dataset, self.file_names[self.curr_episode])
        self.curr_state = StateVector(self.curr_query, self.tables, self.attributes)
        # print(self.curr_state.join_predicates)
        # print(self.curr_state.selection_predicates)

        self.max_steps = self.curr_state.number_of_joins  # ToDo :  max_steps = number of joins

        # Store past actions-per-episode
        # self.action_episode_memory = []

    def step(self, action):

        """
        The agent takes a step in the environment.

        Parameters
        ----------
        action : [int,int]

        Returns
        -------
        ob, reward, episode_over, info : tuple
            ob (object) :
                an environment-specific object representing your observation of
                the environment.
            reward (float) :
                amount of reward achieved by the previous action. The scale
                varies between environments, but the goal is always to increase
                your total reward.
            episode_over (bool) :
                whether it's time to reset the environment again. Most (but not
                all) tasks are divided up into well-defined episodes, and done
                being True indicates the episode has terminated. (For example,
                perhaps the pole tipped too far, or you lost your last life.)
            info (dict) :
                 diagnostic information useful for debugging. It can sometimesBut this isn’t enough; we need to know the amount of a given stock to buy or sell each time. Using gym’s Box space, we can create an action space that has a discrete number of action types (buy, sell, and hold), as well as a continuous spectrum of amounts to buy/sell (0-100% of the account balance/position size respectively).But this isn’t enough; we need to know the amount of a given stock to buy or sell each time. Using gym’s Box space, we can create an action space that has a discrete numbeBut this isn’t enough; we need to know the amount of a given stock to buy or sell each time. Using gym’s Box space, we can create an action space that has a discrete number of action types (buy, sell, and hold), as well as a continuous spectrum of amounts to buy/sell (0-100% of the account balance/position size respectively).r of action types (buy, sell, and hold), as well as a continuous spectrum of amounts to buy/sell (0-100% of the account balance/position size respectively).
                 be useful for learning (for example, it might contain the rawBut this isn’t enough; we need to know the amount of a given stock to buy or sell each time. Using gym’s Box space, we can create an action space that has a discrete number of action types (buy, sell, and hold), as well as a continuous spectrum of amounts to buy/sell (0-100% of the account balance/position size respectively).But this isn’t enough; we need to know the amount of a given stock to buy or sell each time. Using gym’s Box space, we can create an action space that has a discrete number of action types (buy, sell, and hold), as well as a continuous spectrum of amounts to buy/sell (0-100% of the account balance/position size respectively).
                 probabilities behind the environment's last state change).But this isn’t enough; we need to know the amount of a given stock to buy or sell each time. Using gym’s Box space, we can create an action space that has a discrete number of action types (buy, sell, and hold), as well as a continuous spectrum of amounts to buy/sell (0-100% of the account balance/position size respectively).
                 However, official evaluations of your agent are not allowed to
                 use this for learning.
        """
        if self.is_final:
            raise RuntimeError("Episode is done")

        self._take_action(action)
        reward = self._get_reward()
        ob = self._get_state()
        # ob = self.env.getState()
        self.curr_step += 1

        return ob, reward, self.is_final, {}

    def _take_action(self, action):
        assert self._is_action_valid(action)
        self.action_episode_memory[self.curr_step].append(action)  # self.curr_episode

        states = self.observation_space[0]
        s = self._join(states[action[0]], states[action[1]])
        del states[max(action[0], action[1])]
        del states[min(action[0], action[1])]
        states.append(s)
        self.observation_space = states  # ?

    def _get_reward(self):
        """Reward is given for the final state."""
        if self.is_final:
            return 1 / Database.get_reward(self.query, self.action_episode_memory, self.phase)
        else:
            return 0.0

    def reset(self):

        """
        Reset the state of the environment and returns an initial observation.

        Returns
        -------
        observation (object): the initial observation of the space.
        """
        self.curr_step = -1
        self.is_final = False
        # self.action_episode_memory.append([])         # ToDo : important to keep track of past actions for reconstructing the query with the explicit join ordering
        self.curr_episode += 1

        # Read next query
        self.curr_query = self.read_next_query(self.dataset, self.file_names[self.curr_episode])
        state = StateVector(self.curr_query, self.tables, self.attributes)
        print(state.join_predicates)
        print(state.selection_predicates)

        self.max_steps = state.number_of_joins  # ToDo

        return state

    def _render(self, mode='human', close=False):
        return

    def _get_state(self):
        return self.observation_space

    def seed(self, seed):
        random.seed(seed)
        np.random.seed

    def _is_action_valid(self, action):
        # joins = self.observation_space[1]
        # return joins[action[0]][action[1]] == 1
        return True

    def _join(self, s1, s2):
        # 0 1 0 0 0
        # 0 0 1 0 0
        result = [0] * self.TABLES
        for i in range(0, self.TABLES):
            if s1[i] != 0:
                result[i] = s1[i] / 2
            elif s2[i] != 0:
                result[i] = s2[i] / 2
        return result
        # 0 1/2 1/2 0 0

    def _action_space(self):
        jp = self.observation_space[1]
        states = self.observation_space[0]
        action_space = []
        for i in range(0, len(states)):
            for j in range(i + 1, len(states)):
                for idx1, val1 in enumerate(states[i]):
                    for idx2, val2 in enumerate(states[j]):
                        if val1 != 0 and val2 != 0 and jp[idx1][idx2] == 1:
                            action_space.append((i, j))

        return action_space

    def read_next_query(self, dataset, file_name):

        file = open(dataset + "/" + file_name, 'r')
        query = file.read()
        # print(query)
        # print(db.get_query_time(query))

        return query
