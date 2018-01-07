#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program which can compute the factorial of a given numbers.
    The results should be printed in a comma-separated sequence on a single line.
    Suppose the following input is supplied to the program:
    8
    Then, the output should be:
    40320

Answer:""")

import sys

def fact(n):
    p = 1
    for i in range(1,n+1):
        p *= i
    return p
    # if n == 0:
    #     return 1
    # else:
    #     return n*fact(n-1)

fact_list = [str(fact(int(n))) for n in sys.argv[1:]]
print(','.join(fact_list))
