#!/usr/bin/env python3

import numpy as np


def next_step(grid):
    grid += 1
    have_already_flashed = np.zeros(grid.shape, dtype="bool")
    while True:
        flash = np.logical_and(grid > 9, np.logical_not(have_already_flashed))
        if not flash.any():
            break
        flash_neighbors = np.zeros(grid.shape, dtype='int')
        flash_neighbors[1:] += flash[:-1]           # south
        flash_neighbors[:-1] += flash[1:]           # north
        flash_neighbors[:, 1:] += flash[:, :-1]     # east
        flash_neighbors[:, :-1] += flash[:, 1:]     # west
        flash_neighbors[1:, 1:] += flash[:-1, :-1]  # south east
        flash_neighbors[1:, :-1] += flash[:-1, 1:]  # south west
        flash_neighbors[:-1, 1:] += flash[1:, :-1]  # north east
        flash_neighbors[:-1, :-1] += flash[1:, 1:]  # north west
        grid += flash_neighbors
        have_already_flashed = np.logical_or(have_already_flashed, flash)
    grid[grid > 9] = 0
    return grid


def p1(grid):
    s = 0
    for _ in range(100):
        grid = next_step(grid)
        s += np.count_nonzero(grid == 0)
    return s


def p2(grid):
    step_count = 0
    while True:
        grid = next_step(grid)
        step_count += 1
        if np.count_nonzero(grid == 0) == 100:
            break
    return step_count


with open('input.txt', 'r') as f:
    grid = np.array([[int(c) for c in l.strip()] for l in f.readlines()])
    print(p1(grid.copy()))
    print(p2(grid.copy()))
