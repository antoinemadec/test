#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Use a list comprehension to square each odd number in a list. The list is input by a sequence of comma-separated numbers.
    Suppose the following input is supplied to the program:
    1,2,3,4,5,6,7,8,9
    Then, the output should be:
    1,9,25,49,81

Answer:""")

l = [ int(n) for n in input("Enter comma-separated numbers: ").split(',') ]
square_odd_nb = [ str(n**2) for n in l if n%2 == 1 ]
print(','.join(square_odd_nb))
