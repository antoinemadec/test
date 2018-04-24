#!/usr/bin/env python3

"""
(1,2)
(1,1) (2,1)
"""

def answer(x,y):
    s = 0
    diag = x+y-1
    for l in range(1, diag):
        s += l
    s += x
    return str(s)

print(answer(2,3))
print(answer(3,2))
print(answer(5,10))
print(answer(100000,100000))
