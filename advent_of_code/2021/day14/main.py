#!/usr/bin/env python3

def next_step(pair_count, rules):
    new_pair_count = pair_count.copy()
    for pair in rules:
        new_pairs = rules[pair]
        count = pair_count[pair]
        new_pair_count[pair] -= count
        new_pair_count[new_pairs[0]] += count
        new_pair_count[new_pairs[1]] += count
    return new_pair_count


def get_letter_count(pair_count):
    letter_count = {}
    for pair in pair_count:
        letter_count[pair[0]] = letter_count.get(pair[0], 0) + pair_count[pair]
        letter_count[pair[1]] = letter_count.get(pair[1], 0) + pair_count[pair]
    return sorted([i//2 + i % 2 for i in letter_count.values()])


def result(template, rules, steps):
    pair_count = {}
    for pair in rules:
        pair_count[pair] = 0
    for i in range(len(template) - 1):
        pair_count[template[i:i+2]] += 1
    for _ in range(steps):
        pair_count = next_step(pair_count, rules)
    lc = get_letter_count(pair_count)
    return lc[-1] - lc[0]


with open('input.txt', 'r') as f:
    lines = [l.strip() for l in f.readlines()]
    template = lines[0]
    rules = {}
    for l in lines[2:]:
        split = l.split()
        a, b = [char for char in split[0]]
        c = split[2]
        rules[a+b] = (a+c, c+b)
    print(result(template, rules, 10))
    print(result(template, rules, 40))
