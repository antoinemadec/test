#!/usr/bin/env python3

from timeit import Timer
import time

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:

    Please write a program to print the running time of execution of "1+1" for 100 times.



Answer:""")

t = Timer(stmt='1+1')
print('t = %f sec' % t.timeit(number=100))
