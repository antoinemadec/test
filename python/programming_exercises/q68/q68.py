#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:

    Please write a program to output a random even number between 0 and 10 inclusive using random module and list comprehension.



Answer:""")

import random

def rdm():
    return random.choice([i*2 for i in range(0,6)])

for i in range(0,10):
    print(rdm())
