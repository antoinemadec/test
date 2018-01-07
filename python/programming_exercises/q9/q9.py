#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program that accepts a sequence of whitespace separated words as input and prints the words after removing all duplicate words and sorting them alphanumerically.
    Suppose the following input is supplied to the program:
    hello world and practice makes perfect and hello world again
    Then, the output should be:
    again and hello makes perfect practice world

Answer:""")

words = input("Entre space separated words: ").split(' ')
s = sorted(set(words))
print(','.join(s))
