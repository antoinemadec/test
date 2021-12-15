#!/usr/bin/env python3

class Pos:
    pos_dict = {}

    def __init__(self, pos, weight):
        self.pos = pos
        self.weight = weight
        self.lowest_risk = None
        self.pos_dict[pos] = self


def get_ripple_positions(size, i, reverse=False):
    positions = []
    for x in range(size):
        if x > i:
            positions.append((i, x))
    for x in range(size):
        if x > i:
            positions.append((x, i))
    positions.reverse()
    positions.append((i, i))
    if reverse:
        positions.reverse()
    return positions


def compute_lowest_risks(d, size):
    for i in range(size):
        for pos in get_ripple_positions(size, (size-i)-1):
            point = d[pos]
            risks = []
            # FIXME: missing up case when on left, and left case when on top
            for i, j in [(0, 1), (1, 0)]:
                x, y = pos[0]+i, pos[1]+j
                if (x, y) not in d:
                    continue
                risks.append(d[(x, y)].lowest_risk)
            if len(risks) == 0:
                point.lowest_risk = point.weight
            else:
                point.lowest_risk = min(risks) + point.weight


def build_meta_grid(lines, meta_grid_size, size):
    for meta_i in range(meta_grid_size):
        for meta_pos in get_ripple_positions(meta_grid_size, meta_i, reverse=True):
            for i, row in enumerate(lines):
                for j, weight in enumerate(row):
                    x = i + meta_pos[0]*size
                    y = j + meta_pos[1]*size
                    weight += meta_pos[0] + meta_pos[1]
                    if weight > 9:
                        weight -= 9
                    Pos((x, y), weight)


def part12(lines, p2=False):
    size = len(lines)
    meta_grid_size = (1, 5)[p2]
    build_meta_grid(lines, meta_grid_size, size)
    compute_lowest_risks(Pos.pos_dict, size * meta_grid_size)
    return Pos.pos_dict[(0, 0)].lowest_risk - Pos.pos_dict[(0, 0)].weight


with open('input.txt', 'r') as f:
    lines = [[int(c) for c in l.strip()] for l in f.readlines()]
    print(part12(lines))
    print(part12(lines, True))
