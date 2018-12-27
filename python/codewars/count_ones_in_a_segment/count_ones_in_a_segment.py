#!/usr/bin/env python3

'''
Given two numbers: 'left' and 'right' (1 <= 'left' <= 'right' <=
200000000000000) return sum of all '1' occurencies in binary representations of
numbers between 'left' and 'right' (including both)

Example:
countOnes 4 7 should return 8, because:
4(dec) = 100(bin), which adds 1 to the result.
5(dec) = 101(bin), which adds 2 to the result.
6(dec) = 110(bin), which adds 2 to the result.
7(dec) = 111(bin), which adds 3 to the result.
So finally result equals 8.

WARNING: Segment may contain billion elements, to pass this kata, your solution cannot iterate through all numbers in the segment!
'''

# count ones in segment [0:n[
def count_ones_to_n(n):
    n_bin = ""
    while n != 0:
        n_bin = str(n%2) + n_bin
        n >>= 1
    s, preceding_ones = 0, 0
    for i in range(len(n_bin)):
        if n_bin[i] == '1':
            j = len(n_bin)-i-1
            s += preceding_ones*2**j + j*2**(j-1)
            preceding_ones += 1
    return int(s)

def countOnes(left,right):
    return count_ones_to_n(right+1) - count_ones_to_n(left)

print(countOnes(5,7), 7)
print(countOnes(12,29), 51)
