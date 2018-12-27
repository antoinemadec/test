#!/usr/bin/env python3

'''
Given a 2D array and a number of generations, compute n timesteps of Conway's
Game of Life.

The rules of the game are:
    Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
    Any live cell with more than three live neighbours dies, as if by overcrowding.
    Any live cell with two or three live neighbours lives on to the next generation.
    Any dead cell with exactly three live neighbours becomes a live cell.

Each cell's neighborhood is the 8 cells immediately around it (i.e. Moore
Neighborhood). The universe is infinite in both the x and y dimensions and all
cells are initially dead - except for those specified in the arguments. The
return value should be a 2d array cropped around all of the living cells. (If
there are no living cells, then return [[]].)
'''


import numpy as np

def evolve(X):
    ext = np.zeros((X.shape[0]+4,X.shape[1]+4),dtype=int)
    ext[2:-2,2:-2] = X
    neigh = np.zeros((X.shape[0]+2,X.shape[1]+2),dtype=int)
    neigh = ext[0:-2,0:-2] + ext[0:-2,1:-1] + ext[0:-2,2:] +    \
            ext[1:-1,0:-2] +                  ext[1:-1,2:] +    \
            ext[2:  ,0:-2] + ext[2:,1:-1]   + ext[2:  ,2:]
    new = np.logical_or(neigh==3,np.logical_and(ext[1:-1,1:-1]==1,neigh==2)).astype(int)
    r_max, r_min = 0, new.shape[0]
    c_max, c_min = 0, new.shape[1]
    for r in range(new.shape[0]):
        for c in range(new.shape[1]):
            if new[r,c] != 0:
                r_max, r_min = (r_max,r)[r>r_max], (r_min,r)[r<r_min]
                c_max, c_min = (c_max,c)[c>c_max], (c_min,c)[c<c_min]
    return new[r_min:r_max+1, c_min:c_max+1]

def get_generation(mat,n):
    m = np.array(mat, copy=True)
    for i in range(n):
        m = evolve(m)
    return m.tolist() if len(m) else [[]]

start = [[1,0,0],
         [0,1,1],
         [1,1,0]]
end   = [[0,1,0],
         [0,0,1],
         [1,1,1]]

resp = get_generation(start, 1)
# resp = get_generation([[0,0],[0,0]], 4)
# # resp = get_generation([[]], 4)
print(resp, end)
