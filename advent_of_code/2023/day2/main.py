#!/usr/bin/env python3

import re

with open("./input.txt") as f:
    lines = [line.rstrip() for line in f]

part1_sum = 0
part2_sum = 0
cube_max_dict = {"red": 12, "green": 13, "blue": 14}
for l in lines:
    m = re.match(r"Game ([0-9]+): (.*)", l)
    game_id = int(m.group(1))
    cubes_str = m.group(2)
    cube_dict = {"red": 0, "green": 0, "blue": 0}
    for cube_str in re.split(r", |; ", cubes_str):
        n, color = cube_str.split(" ")
        cube_dict[color] = max(int(n), cube_dict[color])

    # part 1
    game_possible = True
    for k in cube_max_dict.keys():
        if cube_max_dict[k] < cube_dict[k]:
            game_possible = False
            break
    if game_possible:
        part1_sum += game_id

    # part 2
    mul = 1
    for v in cube_dict.values():
        mul *= v
    part2_sum += mul

print(part1_sum)
print(part2_sum)
