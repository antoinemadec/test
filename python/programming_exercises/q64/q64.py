#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:

    Please write a binary search function which searches an item in a sorted list. The function should return the index of element to be searched in the list.


Answer:""")


def bin_search(l,e):
    b   = 0
    t   = len(l) - 1
    idx = None
    while t!=b:
        m = int(b + (t-b)/2)
        if e < l[m]:
            t = m - 1
        elif e > l[m]:
            b = m
        else:
            idx = m
            break
    return idx

l = [2,4,6,8,16]
print(bin_search(l,6))
