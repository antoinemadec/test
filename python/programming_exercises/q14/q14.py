#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program that computes the value of a+aa+aaa+aaaa with a given digit as the value of a.
    Suppose the following input is supplied to the program:
    9
    Then, the output should be:
    11106

Answer:""")

d = input("Enter digit: ")
s = "%s+%s+%s+%s" %(d,2*d,3*d,4*d)
eval(s)
