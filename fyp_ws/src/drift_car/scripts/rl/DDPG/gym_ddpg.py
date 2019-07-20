import filter_env
from ddpg import *
import gc
gc.enable()
import gym
import gym_drift_car
ENV_NAME = "DriftCarGazeboContinuous4WD-v0"
EPISODES = 100000
TEST = 10
MAX_STEPS = 300

def main():
    env = filter_env.makeFilteredEnv(gym.make(ENV_NAME))
    agent = DDPG(env)
    # env.monitor.start('experiments/' + ENV_NAME,force=True)
    saver = tf.train.Saver()
    max_reward = -100000
    for episode in xrange(EPISODES):
        state = env.reset()
        print "episode:",episode
        # Train
        for step in xrange(MAX_STEPS):
            action = agent.noise_action(state)
            next_state,reward,done,_ = env.step(action)
            agent.perceive(state,action,reward,next_state,done)
            state = next_state
            if done:
                break
        # Testing:
        if episode % 100 == 0 and episode > 100:
            total_reward = 0
            for i in xrange(TEST):
                state = env.reset()
                for j in xrange(MAX_STEPS):
                    #env.render()
                    action = agent.action(state) # direct action for test
                    state,reward,done,_ = env.step(action)
                    total_reward += reward
                    if done:
                        break
            ave_reward = total_reward/TEST
            if ave_reward > max_reward:
                max_reward = ave_reward
                saver.save(agent.sess, "models/ddpg_ep" + str(episode) + "-" + str(ave_reward))
            print 'episode: ',episode,'Evaluation Average Reward:',ave_reward

    env.monitor.close()

if __name__ == '__main__':
    main()
