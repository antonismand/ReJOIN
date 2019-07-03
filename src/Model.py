# import numpy as np
#
# from tensorforce.agents import PPOAgent
# from tensorforce.execution import Runner
# from tensorforce.contrib.openai_gym import OpenAIGym
#
#
#
# import gym
# env = gym.make('MountainCarContinuous-v0') # try for different environements
# observation = env.reset()
# for t in range(100):
#         env.render()
#         print observation
#         action = env.action_space.sample()                          # Sampling for balancing exploitation and exploration
#         observation, reward, done, info = env.step(action)
#         print observation, reward, done, info
#         if done:
#             print("Finished after {} timesteps".format(t+1))
#             break
#
#
#
#
# ###############
#
# # Create an OpenAIgym environment
# env = OpenAIGym('CartPole-v0', visualize=True)
#
# # Network as list of layers
# network_spec = [
#     dict(type='dense', size=32, activation='tanh'),
#     dict(type='dense', size=32, activation='tanh')
# ]
#
# agent = PPOAgent(
#     states=env.states,
#     actions=env.actions,
#     network=network_spec,
#     batch_size=4096,
#     # BatchAgent
#     keep_last_timestep=True,
#     # PPOAgent
#     step_optimizer=dict(
#         type='adam',
#         learning_rate=1e-3
#     ),
#     optimization_steps=10,
#     # Model
#     scope='ppo',
#     discount=0.99,
#     # DistributionModel
#     distributions_spec=None,
#     entropy_regularization=0.01,
#     # PGModel
#     baseline_mode=None,
#     baseline=None,
#     baseline_optimizer=None,
#     gae_lambda=None,
#     # PGLRModel
#     likelihood_ratio_clipping=0.2,
#     summary_spec=None,
#     distributed_spec=None
# )
#
# # Create the runner
# runner = Runner(agent=agent, environment=env)
#
#
# # Callback function printing episode statistics
# def episode_finished(r):
#     print("Finished episode {ep} after {ts} timesteps (reward: {reward})".format(ep=r.episode, ts=r.episode_timestep,
#                                                                                  reward=r.episode_rewards[-1]))
#     return True
#
#
# # Start learning
# runner.run(episodes=3000, max_episode_timesteps=200, episode_finished=episode_finished)
# runner.close()
#
# # Print statistics
# print("Learning finished. Total episodes: {ep}. Average reward of last 100 episodes: {ar}.".format(
#     ep=runner.episode,
#     ar=np.mean(runner.episode_rewards[-100:]))
# )