import numpy as np
import greetings.hello

def say():
    test_numpy = np.arange(2).reshape(2, 1)

    return greetings.hello.say(test_numpy)
