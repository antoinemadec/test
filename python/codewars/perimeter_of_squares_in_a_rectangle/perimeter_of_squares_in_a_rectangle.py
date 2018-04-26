#!/usr/bin/env python3

"""
The drawing shows 6 squares the sides of which have a length of 1, 1, 2, 3, 5, 8.
It's easy to see that the sum of the perimeters of these squares is : 4 * (1 + 1 + 2 + 3 + 5 + 8) = 4 * 20 = 80

Could you give the sum of the perimeters of all the squares in a rectangle when there are n + 1 squares
See fibonacci suite
"""

def perimeter(n):
    (a,b) = (0,1)
    for i in range(n+2):
        (a,b) = (b, a+b)
    return 4*(b-1)

print(perimeter(0))
print(perimeter(1))
print(perimeter(4))
print(perimeter(5)) # 80
print(perimeter(7)) # 216
print(perimeter(100))
