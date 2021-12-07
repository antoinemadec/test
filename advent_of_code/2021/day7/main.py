#!/usr/bin/env python3

def step_costs(n, part2=False):
    return (n+1)*n//2 if part2 else n

def cost(l, n, part2=False):
    return sum([step_costs(abs(n-pos), part2)*weight for pos,weight in  enumerate(l)])

with open('input.txt', 'r') as f:
    file_list = [int(i) for i in f.readline().strip().split(',')]
    crabs = [file_list.count(i) for i in range(max(file_list)+1)]
    costs = [cost(crabs, n, True) for n in range(len(crabs))]
    print(min(costs))
