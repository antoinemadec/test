#!/usr/bin/env python3

import time

stacks = {}
insts = []
with open('input.txt', 'r') as f:
    init = 1
    for l in f:
        if init == 1:
            for i, c in enumerate(l.rstrip()):
                if c in " []":
                    continue
                elif c.isnumeric():
                    init = 0
                    continue
                else:
                    index = i//4 + 1
                    stacks.setdefault(index, [])
                    stacks[index].append(c)
        else:
            if l[0] == 'm':
                insts.append([int(n) for n in l.split() if n.isnumeric()])


def p(part_nb):
    for n, src, dst in insts:
        slice = stacks[src][0:n]
        if part_nb == 1:
            slice = slice[::-1]
        stacks[dst] = slice + stacks[dst]
        stacks[src] = stacks[src][n:]
    s = ""
    for i in range(len(stacks)):
        s += stacks[i+1][0]
    return s


t0 = time.time()
print(p(2))
print(f'ran in {time.time()-t0:.2}s')
