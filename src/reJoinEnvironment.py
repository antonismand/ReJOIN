from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

import numpy as np

from tensorforce.environments import Environment


class ReJoin(Environment):

    def __init__(
        self,
        repeat_action_probability=0.0,
        tables=21,
        display_screen=False,
        seed=np.random.RandomState()
    ):

        self.stateObject = np.empty((tables, tables), dtype=np.uint8)

        # # Setup action converter.
        # # ALE returns legal action indexes, convert these to just numbers.
        # self.action_inds = self.ale.getMinimalActionSet()

    def __str__(self):
        return 'ALE({})'.format(self.rom)

    def close(self):
        self.ale = None

    def seed(self, seed):
        """
        Sets the random seed of the environment to the given value (current time, if seed=None).
        Naturally deterministic Environments (e.g. ALE or some gym Envs) don't have to implement this method.

        Args:
            seed (int): The seed to use for initializing the pseudo-random number generator (default=epoch time in sec).
        Returns: The actual seed (int) used OR None if Environment did not override this method (no seeding supported).
        """
        return None

    def reset(self):

        """
        Reset environment and setup for new episode.

        Returns:
            initial state of reset environment.
        """

        # self.ale.reset_game()
        # Clear stateObject.
        self.stateObject = np.empty(self.stateObject.shape, dtype=np.uint8)
        return self.current_state

    def execute(self, action):

        """
        Executes action, observes next state(s) and reward.

        Args:
            actions: Actions to execute.

        Returns:
            Tuple of (next state, bool indicating terminal, reward)
        """

        # Convert action to ale action.
        ale_action = self.action_inds[action]

        # Get reward and process terminal & next state.
        reward = get_reward()
        terminal = self.is_terminal
        state_tp1 = self.current_state
        return state_tp1, terminal, reward

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

        return dict(shape=self.stateObject.shape, type=int)

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

        return dict(type='int', num_actions=len(self.action_inds))

    @property
    def current_state(self):
        self.gamescreen = self.ale.getScreenRGB(self.gamescreen)
        return np.copy(self.gamescreen)

    @property
    def is_terminal(self):
        if self.loss_of_life_termination and self.life_lost:
            return True
        else:
            return self.ale.game_over()

    @property
    def action_names(self):
        action_names = [
            'No-Op',
            'Fire',
            'Up',
            'Right',
            'Left',
            'Down',
            'Up Right',
            'Up Left',
            'Down Right',
            'Down Left',
            'Up Fire',
            'Right Fire',
            'Left Fire',
            'Down Fire',
            'Up Right Fire',
            'Up Left Fire',
            'Down Right Fire',
            'Down Left Fire'
        ]
        return np.asarray(action_names)[self.action_inds]
