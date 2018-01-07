#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program that calculates and prints the value according to the given formula:
    Q = Square root of [(2 * C * D)/H]
    Following are the fixed values of C and H:
    C is 50. H is 30.
    D is the variable whose values should be input to your program in a comma-separated sequence.
    Example
    Let us assume the following comma separated input sequence is given to the program:
    100,150,180
    The output of the program should be:
    18,22,24

Answer:""")


C = 50
H = 30

Q = []
for D in input("Enter numbers separated by comma: ").split(','):
    D = int(D)
    Q.append(int(((2*C*D)/H) ** 0.5))

print(','.join([str(i) for i in Q]))
