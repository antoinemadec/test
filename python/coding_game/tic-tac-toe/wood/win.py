#!/usr/bin/env python3

import sys
import math
import random

class TicTacToe:
    """0: nothing; 1: me; -1: opponent"""
    def __init__(self, dim=3):
        self.dim = dim
        self.grid = [[0]*dim for _ in range(dim)]

    def get_legal_coords(self):
        return [(i,j) for i in range(self.dim) for j in range(self.dim) if self.grid[i][j] == 0]

    def get_win_coords(self, player: str):
        wc = []
        win_cnt = (self.dim-1) * (1 if player == "me" else -1)
        for row, col in self.get_legal_coords():
            sr = 0
            sc = 0
            for k in range(self.dim):
                sr += self.grid[row][k]
                sc += self.grid[k][col]
            if sr == win_cnt or sc == win_cnt:
                wc.append((row,col))
        return wc

    def update_grid(self, row: int, col: int, player: str):
        if row == -1 or col == -1:
            return
        self.grid[row][col] = 1 if player == "me" else -1
        g = self.grid
        print(f"{g[0][0]=} {g[0][1]=} {g[0][2]=}", file=sys.stderr, flush=True)
        print(f"{g[1][0]=} {g[1][1]=} {g[1][2]=}", file=sys.stderr, flush=True)
        print(f"{g[2][0]=} {g[2][1]=} {g[2][2]=}", file=sys.stderr, flush=True)

    def play_my_turn(self):
        me_win_coords = self.get_win_coords("me")
        op_win_coords = self.get_win_coords("op")
        if me_win_coords:
            print(f"me_win", file=sys.stderr, flush=True)
            row, col = me_win_coords[0]
        elif op_win_coords:
            print(f"op_win", file=sys.stderr, flush=True)
            row, col = op_win_coords[0]
        else:
            print(f"else", file=sys.stderr, flush=True)
            legal_coords = self.get_legal_coords()
            idx = random.randrange(0, len(legal_coords))
            row, col = legal_coords[idx]
        print(f"{row} {col}")
        self.update_grid(row, col, "me")



# game loop
t = TicTacToe(3)
while True:
    op_row, op_col = [int(i) for i in input().split()]
    t.update_grid(op_row, op_col, "op")

    valid_action_count = int(input())
    for i in range(valid_action_count):
        input()

    t.play_my_turn()
