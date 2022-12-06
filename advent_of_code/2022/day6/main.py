#!/usr/bin/env python3

import time

def detect(n):
    buf = [line[0]] * n
    for i,c in enumerate(line):
        buf[i%n] = c
        if len(set(buf)) == n:
            return i+1

with open('input.txt', 'r') as f:
    line = f.readline()

t0 = time.time()
print(detect(4))
print(f'ran in {time.time()-t0:.2}s')

t0 = time.time()
print(detect(14))
print(f'ran in {time.time()-t0:.2}s')
