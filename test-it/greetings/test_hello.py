import unittest

from greetings import hello

class TestHello(unittest.TestCase):
    def test_hello(self):
        s = hello.say('world')
        self.assertEqual(s, 'Hello world!')
