#!/usr/bin/env python3

def fib_matrix(n):
    v1, v2, v3 = 1, 1, 0
    for rec in bin(n)[3:]:
        calc = v2*v2
        v1, v2, v3 = v1*v1+calc, (v1+v3)*v2, calc+v3*v3
        if rec=='1':    v1, v2, v3 = v1+v2, v1, v2
    return v2

def fib(n):
    sign = 1
    if n < 0:
        n *= -1
        sign = (-1,1)[n%2]
    if n < 2:
        return sign*n
    else:
        print(n)
        return sign*fib_matrix(n)

print(fib(-4))
print(fib(4))
print(fib(1300000))
