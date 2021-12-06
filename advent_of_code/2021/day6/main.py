#!/usr/bin/env python3

import time


def next_day(school):
    due_fishes = school[0]
    school = school[1:9] + [due_fishes]
    school[6] += due_fishes
    return school


with open('input.txt', 'r') as f:
    file_list = [int(i) for i in f.readline().strip().split(',')]
    school = [file_list.count(i) for i in range(9)]
    for _ in range(256):
        school = next_day(school)

t0 = time.time()
print(sum(school))
print(f'part2 ran in {time.time()-t0:.2}s')
