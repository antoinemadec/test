#!/usr/bin/env python3

def square_digits(n):
    return int(''.join([str(d) for d in [int(c)**2 for c in str(n)]]))

print(square_digits(9119), 811181)
