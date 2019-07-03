#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Rejoin Environment
"""

# core modules

import random

# 3rd party modules
from gym import spaces
import gym
import numpy as np
from src.database import Database


class ReJOINEnv(gym.Env):
    """
    The environment defines which actions can be taken at which point and
    when the agent receives which reward.
    """

    def __init__(self, query, max_steps, phase):  # max_steps = number of joins
        # self.__version__ = "0.1.0"

        # General variables defining the environment
        self.TABLES = 21  # todo correct it later

        self.curr_step = -1
        self.is_final = False
        self.query = query  # not sure if string or something else
        self.phase = phase
        self.max_steps = max_steps

        # Define what the agent can do
        self.action_space = spaces.Tuple(
            [spaces.Discrete(self.TABLES), spaces.Discrete(self.TABLES)])  # todo ?

        low = np.array([1 / max_steps, ])
        high = np.array([1, ])
        self.observation_space = spaces.Tuple((
            spaces.Box(low, high, dtype=np.float32),  # tree
            spaces.Box(np.array([0, ]), high, dtype=np.int),  # join predicates
            spaces.Box(np.array([0, ]), high, dtype=np.int)  # todo fix this selection predicates
        ))
        # Store what the agent tried
        self.curr_episode = -1
        self.action_episode_memory = []

    def step(self, action):
        """
        The agent takes a step in the environment.

        Parameters
        ----------
        action : int

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
                 diagnostic information useful for debugging. It can sometimes
                 be useful for learning (for example, it might contain the raw
                 probabilities behind the environment's last state change).
                 However, official evaluations of your agent are not allowed to
                 use this for learning.
        """
        if self.is_final:
            raise RuntimeError("Episode is done")
        self.curr_step += 1
        self._take_action(action)
        reward = self._get_reward()
        ob = self._get_state()  # remove
        # ob = self.env.getState()
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
        self.curr_episode += 1
        self.action_episode_memory.append([])
        self.is_final = False
        return self._get_state()

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
