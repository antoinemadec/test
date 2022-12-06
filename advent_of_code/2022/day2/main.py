#!/usr/bin/env python3

import time

def letter_to_val(letter):
    if letter in ('A', 'B', 'C'):
        return ord(letter) - ord('A')
    return ord(letter) - ord('X')

def p1(round):
    vals = [letter_to_val(l) for l in round]
    mod = (vals[0] - vals[1]) % 3
    s = vals[1] + 1
    if mod == 2:
        s += 6
    elif mod == 1:
        pass
    else:
        s += 3
    return s


def p2(round):
    vals = [letter_to_val(l) for l in round]
    mod = (vals[0] + vals[1] - 1) % 3
    s = mod + 1
    if vals[1] == 2:
        s += 6
    elif vals[1] == 1:
        s += 3
    return s


with open('input.txt', 'r') as f:
    guide = [l.strip().split(' ') for l in f.readlines()]

t0 = time.time()
print(sum([p1(round) for round in guide]))
print(f'ran in {time.time()-t0:.2}s')

t0 = time.time()
print(sum([p2(round) for round in guide]))
print(f'ran in {time.time()-t0:.2}s')
