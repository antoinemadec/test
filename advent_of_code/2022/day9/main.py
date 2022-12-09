#!/usr/bin/env python3

import time


class Rope:
    def __init__(self, size=2):
        self.size = size
        self.knots = [[0, 0] for _ in range(size)]
        self.tails = [tuple([0, 0])]

    def process_motion(self, motion):
        direction, steps = motion[0], int(motion[1])
        head = self.knots[0]
        for _ in range(steps):
            if direction == 'U':
                head[0] += 1
            elif direction == 'D':
                head[0] -= 1
            elif direction == 'R':
                head[1] += 1
            elif direction == 'L':
                head[1] -= 1
            self.update_tail()

    def update_tail(self):
        for knot_idx in range(self.size-1):
            deltas = self.knots[knot_idx][0]-self.knots[knot_idx +
                                                        1][0], self.knots[knot_idx][1]-self.knots[knot_idx+1][1]
            old_self = self.knots[knot_idx+1].copy()
            for i in range(2):
                if deltas[i] < 0:
                    self.knots[knot_idx+1][i] -= 1
                elif deltas[i] > 0:
                    self.knots[knot_idx+1][i] += 1
            if self.knots[knot_idx+1] == self.knots[knot_idx]:
                self.knots[knot_idx+1] = old_self
        self.tails.append(tuple(self.knots[-1]))

    def get_positions_visited_once(self):
        return len(set(self.tails))


with open('input.txt', 'r') as f:
    motions = [l.strip().split() for l in f.readlines()]


t0 = time.time()
rope = Rope(size=10)
for motion in motions:
    rope.process_motion(motion)
print(rope.get_positions_visited_once())
print(f'ran in {time.time()-t0:.2}s')
