#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program which takes 2 digits, X,Y as input and generates a 2-dimensional array. The element value in the i-th row and j-th column of the array should be i*j.
    Note: i=0,1.., X-1; j=0,1,.., Y-1.
    Example
    Suppose the following inputs are given to the program:
    3,5
    Then, the output of the program should be:
    [[0, 0, 0, 0, 0], [0, 1, 2, 3, 4], [0, 2, 4, 6, 8]]

Answer:""")

dim = [int(x) for x in input("Enter dimensions X,Y: ").split(',')]
x_range = range(0,dim[0])
y_range = range(0,dim[1])
# init
m = [[0 for col in y_range] for row in x_range]

for i in x_range:
    for j in y_range:
        m[i][j] = i*j

print(m)
