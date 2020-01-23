import unittest

import numpy_greetings.numpy_hello

class TestNumpyHello(unittest.TestCase):
    def test_numpy_hello(self):
        s = numpy_greetings.numpy_hello.say()
        self.assertEqual(s, 'Hello [[0]\n [1]]!')
