#!/usr/bin/env python3

"""
Write a function called answer(data, n) that takes in a list of less than
100 integers and a number n, and returns that same list but with all of the
numbers that occur more than n times removed entirely. The returned list should
retain the same ordering as the original list - you don't want to mix up those
carefully-planned shift rotations! For instance, if data was [5, 10, 15, 10, 7]
and n was 1, answer(data, n) would return the list [5, 15, 7] because 10 occurs
twice, and thus was removed from the list entirely.
"""

def answer(data,n):
    d = dict((x,data.count(x)) for x in set(data))
    return [x for x in data if d[x] <= n]

print(answer([5, 10, 15, 10, 7], 1))
