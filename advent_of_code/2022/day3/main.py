#!/usr/bin/env python3

import time

with open('input.txt', 'r') as f:
    rucksacks = [l.strip() for l in f.readlines()]

def priority(c: str):
    if c.isupper():
        return ord(c) - 38
    return ord(c) - 96

def p1(rs):
    mid = len(rs) // 2
    c = ""
    for c in rs[0:mid]:
        if c in rs[mid:]:
            break
    return priority(c)

def p2(r0, r1, r2):
    c = ""
    for c in r0:
        if c in r1 and c in r2:
            break
    return priority(c)

t0 = time.time()
print(sum([p1(rs) for rs in rucksacks]))
print(f'ran in {time.time()-t0:.2}s')

t0 = time.time()
print(sum([p2(rucksacks[3*i], rucksacks[3*i+1], rucksacks[3*i+2]) for i in range(len(rucksacks)//3)]))
print(f'ran in {time.time()-t0:.2}s')
