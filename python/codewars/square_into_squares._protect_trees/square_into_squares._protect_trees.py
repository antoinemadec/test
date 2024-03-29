#!/usr/bin/env python3

"""
My little sister came back home from school with the following task: given a
squared sheet of paper she has to cut it in pieces which, when assembled, give
squares the sides of which form an increasing sequence of numbers. At the
beginning it was lot of fun but little by little we were tired of seeing the
pile of torn paper. So we decided to write a program that could help us and
protects trees.  Task

Given a positive integral number n, return a strictly increasing sequence
(list/array/string depending on the language) of numbers, so that the sum of
the squares is equal to n².

If there are multiple solutions (and there will be), return the result with the
largest possible values: Examples

decompose(11) must return [1,2,4,10]. Note that there are actually two ways to
decompose 11², 11² = 121 = 1 + 4 + 16 + 100 = 1² + 2² + 4² + 10² but don't
return [2,6,9], since 9 is smaller than 10.

For decompose(50) don't return [1, 1, 4, 9, 49] but [1, 3, 5, 8, 49] since [1,
1, 4, 9, 49] doesn't form a strictly increasing sequence.  Note

Neither [n] nor [1,1,1,…,1] are valid solutions. If no valid solution exists,
return nil, null, Nothing, None (depending on the language) or "[]" (C) ,{}
(C++), [] (Swift, Go).

The function "decompose" will take a positive integer n and return the
decomposition of N = n² as:

    [x1 ... xk] or "x1 ... xk" or Just [x1 ... xk] or Some [x1 ... xk] or {x1
    ... xk} or "[x1,x2, ... ,xk]"

depending on the language (see "Sample tests") Note for Bash

decompose 50 returns "1,3,5,8,49" decompose 4  returns "Nothing"

Hint

Very often xk will be n-1.
"""

def decompose(n):
    return dec(n**2, n-1)

def dec(total, n, k_array=[]):
    for i in range(n,0,-1):
        t = total - i**2
        a = [i] + k_array
        if t > 0:
            r = dec(t,i-1,a)
            if r != None:
                return r
        elif t == 0:
            return a
    return None

print(decompose(12), [1,2,3,7,9])
print(decompose(6), None)
print(decompose(50), [1,3,5,8,49])
print(decompose(44), [2,3,5,7,43])
print(decompose(625), [2,5,8,34,624])
print(decompose(5), [3,4])
print(decompose(7100), [2,3,5,119,7099])
print(decompose(123456), [1,2,7,29,496,123455])
print(decompose(1234567), [2,8,32,1571,1234566])
print(decompose(7654321), [6, 10, 69, 3912, 7654320])
print(decompose(4), None)
print(decompose(7654322), [1, 4, 11, 69, 3912, 7654321])
