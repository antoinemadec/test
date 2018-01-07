#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program that accepts a sentence and calculate the number of upper case letters and lower case letters.
    Suppose the following input is supplied to the program:
    Hello world!
    Then, the output should be:
    UPPER CASE 1
    LOWER CASE 9

Answer:""")

sentence = input("Enter sentence: ")
u = 0
l = 0
for c in sentence:
    u += int(c.isupper())
    l += int(c.islower())

print("UPPER CASE %0d" % u)
print("LOWER CASE %0d" % l)
