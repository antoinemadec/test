#!/usr/bin/env python3

"""
You have to create a function that takes a positive integer number and returns
the next bigger number formed by the same digits:

next_bigger(12)==21
next_bigger(513)==531
next_bigger(2017)==2071

If no bigger number can be composed using those digits, return -1:

next_bigger(9)==-1
next_bigger(111)==-1
next_bigger(531)==-1
"""

def next_bigger(n):
    a = [ int(c) for c in str(n) ]
    for i in range(len(a)-2,-1,-1):
        try:
            min_greater = min([d for d in a[i+1:] if d>a[i]])
        except:
            continue
        j = a[i+1:].index(min_greater) + i + 1
        if a[i]<a[j]:
            a[i],a[j] = a[j],a[i]
            return int(''.join(str(d) for d in a[:i+1] + sorted(a[i+1:])))
    return -1

print(next_bigger(12),21)
print(next_bigger(513),531)
print(next_bigger(2017),2071)
print(next_bigger(4675),4765)
print(next_bigger(9),-1)
print(next_bigger(111),-1)
print(next_bigger(531),-1)
print(next_bigger(481), 814)
