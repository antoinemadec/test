#!/usr/bin/env python3

import numpy as np


def print_array(a, file="out.txt"):
    a = a.T
    f = open(file, "w")
    Y, X = a.shape
    for y in range(Y):
        f.write("\n")
        for x in range(X):
            f.write(('.', '#')[int(a[y, x])])
    f.close()


def fold_array(array, fold):
    dir, val = fold.split('=')
    val = int(val)
    if dir == 'y':
        up = array[:, :val]
        down = np.fliplr(array[:, val+1:2*val+1])
        fold = np.logical_or(up, down)
    else:
        left = array[:val]
        right = np.flipud(array[val+1:2*val+1])
        fold = np.logical_or(left, right)
    return fold


def p1(array, folds):
    return np.sum(fold_array(array, folds[0]))


def p2(array, folds):
    for fold in folds:
        array = fold_array(array, fold)
    print_array(array)


with open('input.txt', 'r') as f:
    lines = [l.strip() for l in f.readlines()]
    coords = []
    folds = []
    is_coords = True
    max_coord = 0
    for l in lines:
        if not l:
            is_coords = False
            continue
        if is_coords:
            coord = [int(i) for i in l.split(',')]
            coords.append(coord)
            max_coord = max(coord+[max_coord])
        else:
            folds.append(l.split()[-1])
    array = np.zeros((max_coord+1, max_coord+1), dtype="bool")
    array[tuple(np.array(coords).T)] = True
    print(p1(array, folds))
    p2(array, folds)
