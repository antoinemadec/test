#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program which accepts a sequence of comma separated 4 digit binary numbers as its input and then check whether they are divisible by 5 or not. The numbers that are divisible by 5 are to be printed in a comma separated sequence.
    Example:
    0100,0011,1010,1001
    Then the output should be:
    1010
    Notes: Assume the data is input by console.

Answer:""")

dec_nums  = [int(n, base=2) for n in input("Enter comma separated binary numbers: ").split(',')]
div5_nums = [n for n in dec_nums if n%5==0]
print(','.join(bin(n)[2:] for n in div5_nums))
