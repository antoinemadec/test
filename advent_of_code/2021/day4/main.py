#!/usr/bin/env python3

import numpy as np


class Board(object):
    def __init__(self, lines):
        self.board = np.array([line.strip().split()
                              for line in lines], dtype=int)
        self.marked = np.zeros((5, 5), dtype=bool)

    def update_and_get_score(self, n):
        self.marked[self.board == n] = True
        for axis in range(2):
            if 5 in np.sum(self.marked, axis):
                return np.sum(self.board[self.marked == False]) * n
        return None


def create_draw_and_boards():
    boards = []
    with open('input.txt', 'r') as f:
        lines = f.readlines()
        draw = [int(n) for n in lines[0].strip().split(',')]
        for i in range(2, len(lines), 6):
            boards.append(Board(lines[i:i+5]))
    return (draw, boards)


def part1():
    (draw, boards) = create_draw_and_boards()
    for n in draw:
        for b in boards:
            r = b.update_and_get_score(n)
            if r is not None:
                return r
    return None


def part2():
    (draw, boards) = create_draw_and_boards()
    last_result = None
    for n in draw:
        winning_boards = []
        for i, b in enumerate(boards):
            r = b.update_and_get_score(n)
            if r is not None:
                winning_boards.append(i)
                last_result = r
        for i in sorted(winning_boards, reverse=True):
            boards.pop(i)
    return last_result


print(part1())
print(part2())
