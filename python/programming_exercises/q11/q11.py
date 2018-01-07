#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program, which will find all such numbers between 1000 and 3000 (both included) such that each digit of the number is an even number.
    The numbers obtained should be printed in a comma-separated sequence on a single line.

Answer:""")

l = []
for n in range(1000,3001):
    all_even = True
    for c in str(n):
        if int(c)%2 == 0:
            all_even = False
    if all_even:
        l.append(n)
print(l)
