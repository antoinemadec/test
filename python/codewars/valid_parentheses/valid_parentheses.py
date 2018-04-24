#!/usr/bin/env python3

"""
Write a function called that takes a string of parentheses, and determines if
the order of the parentheses is valid. The function should return true if the
string is valid, and false if it's invalid.
"""

def valid_parentheses(s):
    count = 0
    for c in s:
        if c == '(':
            count += 1
        elif c== ')':
            count -= 1
        if count < 0:
            return False
    return count == 0


print(valid_parentheses("  ("))
print(valid_parentheses(")test"))
print(valid_parentheses(""))
print(valid_parentheses("hi())("))
print(valid_parentheses("hi(hi)()"))
