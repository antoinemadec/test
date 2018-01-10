#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:

    Please generate a random float where the value is between 10 and 100 using Python math module.



Answer:""")

import random

for i in range(0,20):
    print(random.random()*90 + 10)
