#!/usr/bin/env python3

import time


def keys_from_val(d, v):
    return [k for k in d if d[k] == v]


def p1(lines):
    count = 0
    for l in lines:
        outputs = l[11:]
        for o in outputs:
            if len(o) in [2, 3, 4, 7]:
                count += 1
    return count


def p2(lines):
    segment_to_number = {
        'abcefg': '0',
        'cf': '1',
        'acdeg': '2',
        'acdfg': '3',
        'bcdf': '4',
        'abdfg': '5',
        'abdefg': '6',
        'acf': '7',
        'abcdefg': '8',
        'abcdfg': '9',
    }
    s = 0
    for l in lines:
        inputs = l[:10]
        outputs = l[11:]
        wire_to_segment = {}
        # use the segment frequencies across the 10 digits to guess the wire_to_segment map
        # 'f': [0, 1, 3, 4, 5, 6, 7, 8, 9],
        # 'a': [0, 2, 3, 5, 6, 7, 8, 9],
        # 'c': [0, 1, 2, 3, 4, 7, 8, 9],
        # 'd': [2, 3, 4, 5, 6, 8, 9],
        # 'g': [0, 2, 3, 5, 6, 8, 9],
        # 'b': [0, 4, 5, 6, 8, 9],
        # 'e': [0, 2, 6, 8],
        wire_freq = {k: "".join(inputs).count(k) for k in "abcdefg"}

        # find f b and e
        wire_to_segment[keys_from_val(wire_freq, 9)[0]] = 'f'
        wire_to_segment[keys_from_val(wire_freq, 6)[0]] = 'b'
        wire_to_segment[keys_from_val(wire_freq, 4)[0]] = 'e'

        # find a c wire_freq and g
        one = [s for s in inputs if len(s) == 2][0]
        four = [s for s in inputs if len(s) == 4][0]
        for wire in keys_from_val(wire_freq, 8):
            wire_to_segment[wire] = ('a', 'c')[wire in one]
        for wire in keys_from_val(wire_freq, 7):
            wire_to_segment[wire] = ('d', 'g')[wire not in four]

        # translate outputs
        output_segments = ["".join(sorted([wire_to_segment[c] for c in o])) for o in outputs]
        number = int("".join([segment_to_number[os] for os in output_segments]))
        s += number
    return s


with open('input.txt', 'r') as f:
    file_list = [l.strip().split() for l in f.readlines()]
    t0 = time.time()
    print(p1(file_list))
    print(f'part1 ran in {time.time()-t0:.2}s')
    t0 = time.time()
    print(p2(file_list))
    print(f'part2 ran in {time.time()-t0:.2}s')
