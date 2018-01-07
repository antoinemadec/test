#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program that accepts a sentence and calculate the number of letters and digits.
    Suppose the following input is supplied to the program:
    hello world! 123
    Then, the output should be:
    LETTERS 10
    DIGITS 3

Answer:""")

sentence = input("Enter sentence: ")
a = 0
d = 0
for c in sentence:
    a += int(c.isalpha())
    d += int(c.isdigit())

print("LETTERS %0d" % a)
print("DIGITS %0d" % d)
