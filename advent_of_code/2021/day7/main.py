#!/usr/bin/env python3

import time


def min_fuel(arr, low, high):
    pos = (high + low) // 2
    cost_pos = cost(arr, pos)
    cost_pos_p1 = cost(arr, pos+1) if pos < (len(arr) - 1) else cost_pos
    cost_pos_m1 = cost(arr, pos-1) if pos > 0 else cost_pos
    if cost_pos <= cost_pos_p1 and cost_pos <= cost_pos_m1:
        return cost_pos
    elif cost_pos_p1 > cost_pos_m1:
        return min_fuel(arr, low, pos)
    else:
        return min_fuel(arr, pos, high)


def step_costs(n):
    global part2
    return (n+1)*n//2 if part2 else n


def cost(l, n):
    return sum([step_costs(abs(n-pos))*weight for pos, weight in enumerate(l)])


def p1(crabs):
    global part2
    part2 = False
    return min_fuel(crabs, 0, len(crabs)-1)


def p2(crabs):
    global part2
    part2 = True
    return min_fuel(crabs, 0, len(crabs)-1)


with open('input.txt', 'r') as f:
    file_list = [int(i) for i in f.readline().strip().split(',')]
    crabs = [file_list.count(i) for i in range(max(file_list)+1)]

    t0 = time.time()
    print(p1(crabs))
    print(f'part2 ran in {time.time()-t0:.2}s')

    t0 = time.time()
    print(p2(crabs))
    print(f'part2 ran in {time.time()-t0:.2}s')
