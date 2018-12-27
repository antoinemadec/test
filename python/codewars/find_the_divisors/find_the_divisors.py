#!/usr/bin/env python3

"""
Create a function named divisors/Divisors that takes an integer and returns an
array with all of the integer's divisors(except for 1 and the number itself).
If the number is prime return the string '(integer) is prime' (null in C#) (use
Either String a in Haskell and Result<Vec<u32>, String> in Rust).

Example:

divisors(12); #should return [2,3,4,6]
divisors(25); #should return [5]
divisors(13); #should return "13 is prime"

You can assume that you will only get positive integers as inputs.
"""

def divisors(i):
    r = [x for x in range(2,i) if (i//x)*x == i]
    if r:
        return r
    else:
        return "%0d is prime" % i

print(divisors(12))
print(divisors(13))
