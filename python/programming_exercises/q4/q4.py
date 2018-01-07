#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program which accepts a sequence of comma-separated numbers from console and generate a list and a tuple which contains every number.
    Suppose the following input is supplied to the program:
    34,67,55,33,12,98
    Then, the output should be:
    ['34', '67', '55', '33', '12', '98']
    ('34', '67', '55', '33', '12', '98')

Answer:""")

foo = input("Enter comma separated list: ")
l = foo.split(',')
print(l)
print(tuple(l))
