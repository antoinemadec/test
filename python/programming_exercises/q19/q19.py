#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Define a class with a generator which can iterate the numbers, which are divisible by 7, between a given range 0 and n.

Answer:""")

def DivBy7(n):
    i = 0
    j = 0
    while j<n:
        j = i*7
        yield j
        i += 1

for i in DivBy7(70):
    print(i)
