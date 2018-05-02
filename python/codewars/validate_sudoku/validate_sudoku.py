#!/usr/bin/env python3

class Sudoku(object):
    def __init__(self, m):
        self.n = len(m)
        self.sqrt_n = int(self.n**0.5)
        if len(m) != 0 and type(m[0][0]) == int and len(m) == len(m[0]) and self.sqrt_n ** 2 == len(m):
            self.invalid_dim = False
            self.m_row = m
            self.m_col = [[None for i in range(self.n)] for j in range(self.n)]
            for i in range(self.n):
                for j in range(self.n):
                    self.m_col[i][j] = m[j][i]
            self.m_sqr = [[None for i in range(self.n)] for j in range(self.n)]
            for i in range(self.n):
                for j in range(self.n):
                    k = (i//self.sqrt_n) * self.sqrt_n + (j//self.sqrt_n)
                    l = (i%self.sqrt_n) * self.sqrt_n + (j%self.sqrt_n)
                    self.m_sqr[k][l] = m[i][j]
        else:
            self.invalid_dim = True

    def is_valid(self):
        if self.invalid_dim:
            return False
        range_1_to_n = [x for x in range(1,self.n+1)]
        # rows
        for e in self.m_row:
            if sorted(e) != range_1_to_n:
                return False
        # columns
        for e in self.m_col:
            if sorted(e) != range_1_to_n:
                return False
        # squares
        for e in self.m_sqr:
            if sorted(e) != range_1_to_n:
                return False
        return True

goodSudoku1 = Sudoku([
    [7,8,4, 1,5,9, 3,2,6],
    [5,3,9, 6,7,2, 8,4,1],
    [6,1,2, 4,3,8, 7,5,9],

    [9,2,8, 7,1,5, 4,6,3],
    [3,5,7, 8,4,6, 1,9,2],
    [4,6,1, 9,2,3, 5,8,7],

    [8,7,6, 3,9,4, 2,1,5],
    [2,4,3, 5,6,1, 9,7,8],
    [1,9,5, 2,8,7, 6,3,4]
    ])

goodSudoku2 = Sudoku([
    [1,4, 2,3],
    [3,2, 4,1],

    [4,1, 3,2],
    [2,3, 1,4]
    ])

# Invalid Sudoku
badSudoku1 = Sudoku([
    [0,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],

    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],

    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9],
    [1,2,3, 4,5,6, 7,8,9]
    ])

badSudoku2 = Sudoku([
    [1,2,3,4,5],
    [1,2,3,4],
    [1,2,3,4],
    [1]
    ])


print(goodSudoku1.is_valid())
print(goodSudoku2.is_valid())
print(badSudoku1.is_valid())
print(badSudoku2.is_valid())
