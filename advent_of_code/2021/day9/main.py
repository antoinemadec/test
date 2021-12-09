#!/usr/bin/env python3

import time

import numpy as np


def get_low_point_mask(array):
    row_extra = np.ones((1, array.shape[1])) * 10
    col_extra = np.ones((array.shape[0], 1)) * 10
    a = np.vstack([array[1:], row_extra])
    b = np.vstack([row_extra, array[:-1]])
    c = np.hstack([array[:, 1:], col_extra])
    d = np.hstack([col_extra, array[:, :-1]])
    mask = np.logical_and(np.logical_and(array < a, array < b),
                          np.logical_and(array < c, array < d))
    return mask


# should be doable with raster scan
def fill_labels(array, labels, coord):
    shape = array.shape
    i, j = coord
    labels[i, j] = 1
    for x, y in ((i, j-1), (i, j+1), (i-1, j), (i+1, j)):
        if x < 0 or y < 0 or x >= shape[0] or y >= shape[1]:
            continue
        if labels[x, y] == 0 and array[x, y] != 9:
            labels = fill_labels(array, labels, (x, y))
    return labels


def p1(array):
    coord = get_low_point_mask(array)
    low_points = array[coord]
    return sum(low_points+1)


def p2(array):
    coords = np.argwhere(get_low_point_mask(array))
    basin_sizes = []
    for c in coords:
        labels = np.zeros(array.shape)
        labels = fill_labels(array, labels, c)
        basin_sizes.append(np.sum(labels))
    largest_sizes = sorted(basin_sizes)[-3:]
    return int(largest_sizes[0] * largest_sizes[1] * largest_sizes[2])


with open('input.txt', 'r') as f:
    array = np.array([[int(c) for c in l.strip()] for l in f.readlines()])
    t0 = time.time()
    print(p1(array))
    print(f'part1 ran in {time.time()-t0:.2}s')
    t0 = time.time()
    print(p2(array))
    print(f'part2 ran in {time.time()-t0:.2}s')
