#!/usr/bin/env python3

# Your Mission:
# Given a string containing the current state of the control crystals inner
# pathways (labeled as "X") and its gaps (labeled as "."), generate the
# shortest path from the start node (labeled as "S") to the goal node (labeled
# as "G") and return the new pathway (labeled with "P" characters).  If no
# solution is possible, return the string "Oh for crying out loud..." (in
# frustration).

# The Rules
# - Nodes labeled as "X" are not traversable.
# - Nodes labeled as "." are traversable
# - A pathway can be grown in eight directions (up, down, left, right, up-left, up-right, down-left,
#       down-right), so diagonals are possible.
# - Nodes labeled "S" and "G" are not to be replaced with "P" in the case of a solution.
# - The shortest path is defined as the path with the shortest euclidiean distance going from one
#       node to the next.
# - If several paths are possible with the same shortest distance, return any one of them.

# Note that the mazes won't always be squares.


class Node:
    goal_pos = ()
    trav_pos_array = []
    possible_paths = []

    def __init__(self, pos, prev_pos_array=[], path_distance=0):
        self.pos = pos
        self.prev_pos_array = prev_pos_array
        self.path_distance = path_distance
        self.children = []

    def explore(self):
        prev_pos_array = self.prev_pos_array + [self.pos]
        for vec in ((-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)):
            new_pos = (self.pos[0] + vec[0], self.pos[1] + vec[1])
            if (new_pos not in self.prev_pos_array) and (new_pos in Node.trav_pos_array):
                path_distance = self.path_distance + (2**.5, 1)[vec[0] == 0 or vec[1] == 0]
                if new_pos == Node.goal_pos:
                    Node.possible_paths.append((path_distance, prev_pos_array + [new_pos]))
                else:
                    self.children.append(Node(new_pos, prev_pos_array, path_distance))
                    self.children[-1].explore()


def wire_DHD_SG1(existingWires):
    m = [[l for l in s] for s in existingWires.split()]
    Node.trav_pos_array = []
    Node.possible_paths = []
    for x in range(len(m)):
        for y in range(len(m[0])):
            if m[x][y] == '.':
                Node.trav_pos_array.append((x, y))
            elif m[x][y] == 'S':
                pos = (x, y)
            elif m[x][y] == 'G':
                Node.trav_pos_array.append((x, y))
                Node.goal_pos = (x, y)
    root = Node(pos)
    root.explore()
    if Node.possible_paths == []:
        return "Oh for crying out loud..."
    else:
        Node.possible_paths.sort()
        for (a, b) in Node.possible_paths[0][1][1:-1]:
            m[a][b] = 'P'
    return "\n".join(["".join(r) for r in m])


# -------------------------------------------------------------
# test
# -------------------------------------------------------------
# existingWires = """
# SX.
# XX.
# ..G
# """.strip('\n')
# solution = "Oh for crying out loud..."
# print(wire_DHD_SG1(existingWires), solution)

print("COUCOU")
existingWires = """
S...
....
....
...G
""".strip('\n')
print(wire_DHD_SG1(existingWires))


# existingWires = """
# SX.
# X..
# XXG
# """.strip('\n')
# solution = """
# SX.
# XP.
# XXG
# """.strip('\n')
# print(wire_DHD_SG1(existingWires), solution)

# existingWires = """
# .S.
# ...
# .G.
# """.strip('\n')
# solution = """
# .S.
# .P.
# .G.
# """.strip('\n')
# print(wire_DHD_SG1(existingWires), solution)


# existingWires = """
# .S...
# XXX..
# .X.XX
# ..X..
# G...X
# """.strip('\n')
# solution = """
# .SP..
# XXXP.
# .XPXX
# .PX..
# G...X
# """.strip('\n')
# print(wire_DHD_SG1(existingWires), solution)
