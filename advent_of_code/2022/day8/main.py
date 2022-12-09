#!/usr/bin/env python3

import time


with open('input.txt', 'r') as f:
    lines = [l.strip() for l in f.readlines()]
    grid = [[int(c) for c in l] for l in lines]


class ScenicScore():
    def __init__(self, row, column, height):
        self.row = row
        self.column = column
        self.height = height
        self.scores = [0,0,0,0]

    def look_around(self):
        length = len(grid)
        # left to right
        for column in range(self.column+1, length):
            self.scores[0] += 1
            if grid[self.row][column] >= self.height:
                break
        # right to left
        for column in range(self.column-1, -1, -1):
            self.scores[1] += 1
            if grid[self.row][column] >= self.height:
                break
        # top to bottom
        for row in range(self.row+1, length):
            self.scores[2] += 1
            if grid[row][self.column] >= self.height:
                break
        # top to bottom
        for row in range(self.row-1, -1, -1):
            self.scores[3] += 1
            if grid[row][self.column] >= self.height:
                break
        return self

    def get_score(self):
        p = 1
        for score in self.scores:
            p *= score
        return p


def p1():
    length = len(grid)
    visible = [[0]*length for i in range(length)]
    # left to right
    for row in range(length):
        max = -1
        for column in range(length):
            tree_height = grid[row][column]
            if tree_height > max:
                visible[row][column] = 1
                max = tree_height
    # right to left
    for row in range(length):
        max = -1
        for column in range(length-1,-1,-1):
            tree_height = grid[row][column]
            if tree_height > max:
                visible[row][column] = 1
                max = tree_height
    # top to bottom
    for column in range(length):
        max = -1
        for row in range(length):
            tree_height = grid[row][column]
            if tree_height > max:
                visible[row][column] = 1
                max = tree_height
    # bottom to top
    for column in range(length):
        max = -1
        for row in range(length-1,-1,-1):
            tree_height = grid[row][column]
            if tree_height > max:
                visible[row][column] = 1
                max = tree_height
    return sum(map(sum, visible))


def p2():
    length = len(grid)
    senic_scores : list[ScenicScore] = []
    for row in range(length):
        for column in range(length):
            senic_scores.append(ScenicScore(row, column, grid[row][column]).look_around())
    return max([s.get_score() for s in senic_scores])


t0 = time.time()
print(p1())
print(f'ran in {time.time()-t0:.2}s')

t0 = time.time()
print(p2())
print(f'ran in {time.time()-t0:.2}s')
