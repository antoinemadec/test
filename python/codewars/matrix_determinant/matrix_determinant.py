#!/usr/bin/env python3

"""
Write a function that accepts a square matrix (n x n 2D array) and returns the
determinant of the matrix.

How to take the determinant of a matrix -- it is simplest to start with the
smallest cases: A 1x1 matrix |a| has determinant a. A 2x2 matrix [[a, b], [c,
d]] or

|a b|
|c d|

has determinant ad - bc.

The determinant of an n x n sized matrix is calculated by reducing the problem
to the calculation of the determinants of n n-1 x n-1 matrices. For the 3x3
case, [[a, b, c], [d, e, f], [g, h, i]] or

|a b c|
|d e f|
|g h i|

the determinant is: a * det(a_minor) - b * det(b_minor) + c * det(c_minor)
where det(a_minor) refers to taking the determinant of the 2x2 matrix created
by crossing out the row and column in which the element a occurs, or

|e f|
|h i|

Note the alternation of signs.

The determinant of larger matrices are calculated analogously, e.g. if M is a
4x4 matrix with first row [a, b, c, d], det(M) = a * det(a_minor) - b *
det(b_minor) + c * det(c_minor) - d * det(d_minor)
"""

def determinant(m):
    if len(m) == 1:
        return m[0][0]
    return sum([k * (1,-1)[i%2] * determinant([a[:i] + a[i+1:] for a in m[1:]]) for i,k in enumerate(m[0])])

m1 = [ [1, 3], [2,5]]
m2 = [ [2,5,3], [1,-2,-1], [1, 3, 4]]
print(determinant([[7]]))
print(determinant(m1))
print(determinant(m2))
