#!/usr/bin/env python3

mem = {0:0, 1:1}

def fibo(n):
    if n not in mem:
        mem[n] = fibo(n-1) + fibo(n-2)
    return mem[n]

def ifibo(n):
    a = 0
    b = 1
    for i in range(n-1):
        a,b = b, a+b
    return b

print(fibo(999))

print(ifibo(9999))
