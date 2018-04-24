#!/usr/bin/env python3

"""
Directions Reduction
… a man was given directions to go from one point to another. The directions
were "NORTH", "SOUTH", "WEST", "EAST". Clearly "NORTH" and "SOUTH" are
opposite, "WEST" and "EAST" too. Going to one direction and coming back the
opposite direction is a needless effort. Since this is the wild west, with
dreadfull weather and not much water, it's important to save yourself some
energy, otherwise you might die of thirst!

Note

Not all paths can be made simpler. The path ["NORTH", "WEST", "SOUTH", "EAST"]
is not reducible. "NORTH" and "WEST", "WEST" and "SOUTH", "SOUTH" and "EAST"
are not directly opposite of each other and can't become such. Hence the result
path is itself : ["NORTH", "WEST", "SOUTH", "EAST"].
"""

val = {'NORTH': 1, 'SOUTH': -1, 'EAST': 2, 'WEST': -2, '': 0}

def dirReduc(arr):
    r = []
    for d in arr:
        if r and val[d] + val[r[-1]] == 0:
            r.pop()
        else:
            r.append(d)
    return r

a = ["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]
print(dirReduc(a))
u = ["NORTH", "WEST", "SOUTH", "EAST"]
print(dirReduc(u))
