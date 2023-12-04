#!/usr/bin/env python3

# part 1
with open("./input.txt") as f:
    lines = [line.rstrip() for line in f]

s = 0
for l in lines:
    n_str = [c for c in l if c.isdigit()]
    calibration_input = int(n_str[0] + n_str[-1])
    s += calibration_input

print(s)


# part 2
d = {
    "0": 0,
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9,
}
with open("./input.txt") as f:
    lines = [line.rstrip() for line in f]

def find_all(a_str, sub):
    start = 0
    while True:
        start = a_str.find(sub, start)
        if start == -1: return
        yield start
        start += len(sub) # use start += 1 to find overlapping matches

s = 0
for l in lines:
    idx_dict = {}
    for k in d.keys():
        for idx in find_all(l, k):
            idx_dict[idx] = d[k]
    indexes = sorted(idx_dict.keys())
    idx_first = indexes[0]
    idx_last = indexes[-1]
    n = idx_dict[idx_first]*10 + idx_dict[idx_last]
    s += n

print(s)
