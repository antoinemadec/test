#!/usr/bin/env python3

"""
Write a program that counts how many salutes are exchanged during a typical
walk along a hallway. The hall is represented by a string. For example:
"--->-><-><-->-"

Each hallway string will contain three different types of characters: '>', an
employee walking to the right; '<', an employee walking to the left; and '-',
an empty space. Every employee walks at the same speed either to right or to
the left, according to their direction. Whenever two employees cross, each of
them salutes the other. They then continue walking until they reach the end,
finally leaving the hallway. In the above example, they salute 10 times.

Write a function answer(s) which takes a string representing employees walking
along a hallway and returns the number of times the employees will salute. s
will contain at least 1 and at most 100 characters, each one of -, >, or <.

Test cases
==========

Inputs:
    (string) s = ">----<"
Output:
    (int) 2

Inputs:
    (string) s = "<<>><"
Output:
    (int) 4
"""


def answer(s):
    l_indexes = []
    r_indexes = []
    for n in range(0,len(s)):
        c = s[n]
        if c == '>':
            r_indexes.append(n)
        elif c == '<':
            l_indexes.append(n)
    return sum([sum([2 for x in l_indexes if x>n]) for n in r_indexes])

print(answer(">----<"))
print(answer("<<>><"))
print(answer("><><"))
