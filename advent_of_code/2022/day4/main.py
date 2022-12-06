#!/usr/bin/env python3

import time

with open('input.txt', 'r') as f:
    pairs_list_string = [l.strip().split(',') for l in f.readlines()]
    pairs_list = []
    for pairs in pairs_list_string:
        p = [[],[]]
        for i in range(2):
            p[i] = [int(j) for j in pairs[i].split('-')]
        pairs_list.append(p)

def is_in(val, interval):
    return val <= interval[1] and val >= interval[0]

def p1(p):
    if (is_in(p[0][0], p[1]) and is_in(p[0][1], p[1])) or (is_in(p[1][0], p[0]) and is_in(p[1][1], p[0])):
        return 1
    return 0

def p2(p):
    if is_in(p[0][0], p[1]) or is_in(p[0][1], p[1]) or is_in(p[1][0], p[0]) or is_in(p[1][1], p[0]):
        return 1
    return 0

t0 = time.time()
print(sum([p1(p) for p in pairs_list]))
print(f'ran in {time.time()-t0:.2}s')

t0 = time.time()
print(sum([p2(p) for p in pairs_list]))
print(f'ran in {time.time()-t0:.2}s')
