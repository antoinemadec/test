#!/usr/bin/env python3

'''
The following figure shows a cell grid with 6 cells (2 rows by 3 columns), each
cell separated from the others by walls:

+--+--+--+
|  |  |  |
+--+--+--+
|  |  |  |
+--+--+--+

This grid has 6 connectivity components of size 1. We can describe the size and
number of connectivity components by the list [(1, 6)], since there are 6
components of size 1.

If we tear down a couple of walls, we obtain:

+--+--+--+
|  |     |
+  +--+--+
|  |  |  |
+--+--+--+

, which has two connectivity components of size 2 and two connectivity
components of size 1. The size and number of connectivity components is
described by the list [(2, 2), (1, 2)].

Given the following grid:

+--+--+--+
|     |  |
+  +--+--+
|     |  |
+--+--+--+

we have the connectivity components described by [(4, 1), (1, 2)].

Your job is to define a function components(grid) that takes as argument a
string representing a grid like in the above pictures and returns a list
describing the size and number of the connectivity components. The list should
be sorted in descending order by the size of the connectivity components. The
grid may have any number of rows and columns.

Note: The grid is always rectangular and will have all its outer walls. Only
inner walls may be missing. The + are considered bearing pillars, and are
always present.
'''

import numpy as np
import re

# O: cell,no wall
# -1: not labelled yet
def components(grid):
    # string to matrix
    i,j,n = 0,0,0
    m = []
    for r in grid.splitlines():
        s = r.strip()
        a = []
        while j < len(s):
            w = 1 + n%2
            a.append(int(s[j:j+w] in ('  ', ' ')))
            j += w
            n += 1
        m.append(a)
        i,j,n = i+1,0,0
    m = -1 * np.array(m)
    # create labels
    label = 1
    for i in range(1,m.shape[0]-1):
        for j in range(1,m.shape[1]-1):
            if m[i,j] == -1:
                neighbors = [(i,j)]
                n = 0
                while neighbors:
                    k,l = neighbors.pop()
                    if m[k,l] == -1:
                        n += 1
                        m[k,l] = label
                        neighbors.extend([(x,y) for x in range(k-1,k+2) \
                                for y in range(l-1,l+2) if m[x,y] == -1])
                label += 1
    m = np.array([[v for j,v in enumerate(r) if j%2] for i,r in enumerate(m) if i%2])
    # return result
    d = {}
    for l in range(1,label):
        n = sum([1 for i in range(m.shape[0]) for j in range(m.shape[1]) if m[i][j]==l])
        d[n] = d.get(n,0) + 1
    return sorted(d.items(),reverse=True)

print(components('''\
        +--+--+--+
        |  |  |  |
        +--+--+--+
        |  |  |  |
        +--+--+--+'''), [(1, 6)])

print(components('''\
        +--+--+--+
        |  |     |
        +  +  +--+
        |  |  |  |
        +--+--+--+'''), [(3, 1), (2, 1), (1, 1)])

print(components('''\
        +--+--+--+
        |  |     |
        +  +  +--+
        |        |
        +--+--+--+'''), [(6, 1)])

print(components('''\
        +--+--+--+
        |        |
        +  +  +  +
        |        |
        +--+--+--+'''), [(6, 1)])
