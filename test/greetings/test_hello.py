import unittest

import greetings.hello

class TestHello(unittest.TestCase):
    def test_hello(self):
        s = greetings.hello.say('world')
        self.assertEqual(s, 'Hello world!')
