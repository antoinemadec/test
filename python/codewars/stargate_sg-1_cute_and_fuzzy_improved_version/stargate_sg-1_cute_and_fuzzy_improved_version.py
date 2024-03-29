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
    def __init__(self, pos, is_goal=0):
        self.pos = pos
        self.is_goal = is_goal
        self.children = []
        self.shortest_path_to_goal = None

    def add_child(self, obj):
        self.children.append(obj)

    def find_shortest_path_to_goal(self, parents_pos=[]):
        """returns shortest [distance, [(self.pos),... ,(pos_goal)]]"""
        if self.shortest_path_to_goal is None:
            if self.is_goal:
                self.shortest_path_to_goal = [0, [self.pos]]
            else:
                paths = []
                for c in [x for x in self.children if x.pos not in parents_pos]:
                    p = c.find_shortest_path_to_goal([self.pos] + parents_pos)
                    if p != []:
                        [child_distance, child_path] = p
                        if self.pos not in child_path:
                            delta_d = ((c.pos[0]-self.pos[0])**2 + (c.pos[1]-self.pos[1])**2)**.5
                            paths.append([child_distance + delta_d, [self.pos] + child_path])
                if paths == []:
                    self.shortest_path_to_goal = []
                else:
                    paths.sort()
                    self.shortest_path_to_goal = paths[0]
        return self.shortest_path_to_goal


class Tree:
    NEIGHBORHOOD = ((-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1))

    def __init__(self, m):
        self.m = m
        self.node_dict = {}
        self.start_pos = None

    def create_node(self, pos, is_goal=0):
        if pos not in self.node_dict:
            self.node_dict[pos] = Node(pos, is_goal)
        if is_goal:
            self.node_dict[pos].is_goal = 1

    def populate_tree(self):
        X = len(self.m)
        Y = len(self.m[0])
        for x in range(X):
            for y in range(Y):
                if self.m[x][y] == '.' or self.m[x][y] == 'S':
                    self.create_node((x, y))
                    if self.m[x][y] == 'S':
                        self.start_pos = (x, y)
                    for vec in Tree.NEIGHBORHOOD:
                        (k, l) = (x+vec[0], y+vec[1])
                        if k in range(X) and l in range(Y):
                            self.create_node((k, l))
                            self.node_dict[(x, y)].add_child(self.node_dict[(k, l)])
                elif self.m[x][y] == 'G':
                    self.create_node((x, y), is_goal=1)

    def find_shortest_path_to_goal(self):
        return self.node_dict[self.start_pos].find_shortest_path_to_goal()


def wire_DHD_SG1(existingWires):
    m = [[l for l in s] for s in existingWires.split()]
    t = Tree(m)
    t.populate_tree()
    path = t.find_shortest_path_to_goal()
    if path == []:
        return "Oh for crying out loud..."
    else:
        for (a, b) in path[1][1:-1]:
            m[a][b] = 'P'
    print(path[0])
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


# def gen_input_pattern(n=73):
#     s = "S" + (n-1)*"." + "\n"
#     for i in range(n-2):
#         s += n*"." + "\n"
#     s += (n-1)*"."+"G"
#     return s


# print(wire_DHD_SG1(gen_input_pattern(5)))

# TODO:
# Length: 	35.04163056034262
# Expected:	30.213203435596434
existingWires = """
...X..X.X.....X..XXXX.GXXX
XX.X.XX..X..X.X..XX.XXX...
XXXX.X.X.X..X.XXXX.X.X.X.X
XX..XX.X.X.XXXXXXXXX..X..X
XXXXX.X.X.XXX..X.XXXX...XX
.XX.X..XX.X.XX.X.XXXXX.XX.
...XXX.X.XXXXX.XXXX...X.XX
.X.XXXXX.X....XXXX..XXX..X
XXX..X..XX.XXXXXX.XXX..X.X
XX....XX..X.X....X...X.X.X
..XXX.XXXXX..X..XX.XXXX.X.
...X..XXXX.X...X.XXX..XX.X
..XX.XX.XXX.XXX.XXXXXX.X..
XX.XXXXX...X..X.XX...XX...
XX.X.....XXX.X.XX.XX.XX..X
.X...X.XX.XXX.X..X.X.XXX.X
XX.X..XXX.XXX.....XXX.XXX.
.XX.X.XX.XXX...X.X..XXXXX.
...X.XX.X.X..XXX..X..X.X.X
XXXXXXX......XXX...X...XX.
X..X.XXX..XX..X.XX..XXXXXX
XXX...XX.X.XX.XXXXXXXX...X
X.X.XXX.X.XX.SX.XXX.XX.XXX
..XXXX..X..XX..X..X....X.X
X..XXX.XXX..X..X.X.X.X..X.
XX.X.X......XX..XX.X.XX..X
""".strip('\n')
print(wire_DHD_SG1(existingWires))
