#!/usr/bin/env python3

"""
You have an array of numbers.
Your task is to sort ascending odd numbers but even numbers must be on their places.

Zero isn't an odd number and you don't need to move it. If you have an empty array, you need to return it.
"""

def sort_array(a):
    odd = sorted([x for x in a if x%2], reverse=True)
    return [x if x%2==0 else odd.pop() for x in a]

print(sort_array([5, 3, 2, 8, 1, 4]))
print(sort_array([5, 3, 1, 8, 0]))
