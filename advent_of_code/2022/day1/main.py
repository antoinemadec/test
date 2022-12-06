#!/usr/bin/env python3

import time


t0 = time.time()
with open('input.txt', 'r') as f:
    elfs = [0]
    for l in f:
        l = l.strip()
        if l:
            elfs[-1] += int(l)
        else:
            elfs.append(0)
    elfs.sort(reverse=True)
    print(sum(elfs[0:3]))
print(f'ran in {time.time()-t0:.2}s')
