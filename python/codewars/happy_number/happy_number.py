#!/usr/bin/env python3

"""
This kata is based on a variation of Happy Numbers by TySlothrop. It is
advisable to complete it first to grasp the idea and then move on to this one.

Hello, my dear friend, and welcome to another Happy Numbers kata! What? You're
not interested in them anymore? They are all the same? But what if I say that
this one is a performance version...
Your task:

Write a function performant_numbers which takes a number n as an argument and
returns a list of all happy numbers from 1 to n inclusive. For example:

performant_numbers(10) ==> [1, 7, 10]
performant_numbers(50) ==> [1, 7, 10, 13, 19, 23, 28, 31, 32, 44, 49]
performant_numbers(100) ==> [1, 7, 10, 13, 19, 23, 28, 31, 32, 44, 49, 68, 70, 79, 82, 86, 91, 94, 97, 100]

Test suite:
    5000 tests with number n being up to 300000
    As the reference solution takes around 4.6 seconds to get the result, you are left with only 6.9 more
    you are not allowed to hardcode the sequence: you'll have to compute it (max length of the code: 1700 characters)
"""

happy_set = set()
sad_set = set()
def is_happy(n):
    seq = []
    while n not in seq:
        if n in happy_set:
            happy_set.update(seq)
            return True
        elif n in sad_set:
            sad_set.update(seq)
            return False
        else:
            seq.append(n)
            n = sum([int(d)**2 for d in str(n)])
            if n == 1:
                happy_set.update(seq)
                return True
    sad_set.update(seq)
    return False

pn_max = [x for x in range(1,300000+1) if is_happy(x)]
def performant_numbers(n):
    l,h = 0, len(pn_max)-1
    m = (h+l)//2
    if n>= pn_max[-1]:
        return pn_max
    else:
        while not(pn_max[m] <= n and pn_max[m+1] > n):
            if pn_max[m] < n:
                l,h = m,h
            else:
                l,h = l,m
            m = (h+l+1)//2
        return pn_max[:m+1]

import random
for i in range(5000):
    r = random.randrange(0,300000)
    performant_numbers(r)
