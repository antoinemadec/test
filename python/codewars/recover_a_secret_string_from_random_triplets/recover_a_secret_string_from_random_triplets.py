#!/usr/bin/env python3

"""
There is a secret string which is unknown to you. Given a collection of random
triplets from the string, recover the original string.

A triplet here is defined as a sequence of three letters such that each letter
occurs somewhere before the next in the given string. "whi" is a triplet for
the string "whatisup".

As a simplification, you may assume that no letter occurs more than once in the secret string.

You can assume nothing about the triplets given to you other than that they are
valid triplets and that they contain sufficient information to deduce the
original string. In particular, this means that the secret string will never
contain letters that do not occur in one of the triplets given to you.
"""


def recoverSecret(triplets):
    r = []
    for t in triplets:
        r.extend(t)
    r = list(set(r))
    for t in triplets:
        move(r, t[1], t[2])
        move(r, t[0], t[1])
    print(r)

def move(l, a, b):
    ia = l.index(a)
    ib = l.index(b)
    if ia > ib:
        l.remove(a)
        l.insert(ib, a)

secret = "whatisup"
triplets = [
        ['t','u','p'],
        ['w','h','i'],
        ['t','s','u'],
        ['a','t','s'],
        ['h','a','i'],
        ['t','i','s'],
        ['w','h','s']
        ]

print(recoverSecret(triplets))
