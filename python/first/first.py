#!/usr/bin/env python3

'a test model'

__author__ = 'wpz'

import sys

def test():
    args = sys.argv
    if len(args) == 1:
        print('hello world')
    elif len(args) == 2:
        print(args[1])
    else:
        print('too many arguments')

class Student(object):
    def __init__(self, name, age):
        self.name = name
        self.age = age


if __name__ == '__main__':
    test()


