#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program that computes the net amount of a bank account based a transaction log from console input. The transaction log format is shown as following:
    D 100
    W 200

    D means deposit while W means withdrawal.
    Suppose the following input is supplied to the program:
    D 300
    D 300
    W 200
    D 100
    Then, the output should be:
    500

Answer:""")

print("Enter 'W <value>' for withdrawal, 'D <value>' for deposit, nothing to finish and get total:")
line = input()
total = 0
while line != "":
    op  = line[0]
    val = int(line[2:])
    total += val*(-1,1)[op == "D"]
    line = input()
print(total)
