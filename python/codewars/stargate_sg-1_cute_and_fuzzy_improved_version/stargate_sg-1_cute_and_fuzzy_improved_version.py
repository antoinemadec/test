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

NEIGHBORHOOD = ((-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1))


class Node:
    def __init__(self, pos, is_goal=0):
        self.pos = pos
        self.is_goal = is_goal
        self.children = []
        self.shortest_path_to_goal = None

    def add_child(self, obj):
        self.children.append(obj)

    def find_shortest_path_to_goal(self, parent_pos=[]):
        """returns shortest [distance, [(self.pos),... ,(pos_goal)]]"""
        if self.shortest_path_to_goal is None:
            if self.is_goal:
                self.shortest_path_to_goal = [0, [self.pos]]
            else:
                paths = []
                for c in [x for x in self.children if x != parent_pos]:
                    p = c.find_shortest_path_to_goal(self.pos)
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
    def __init__(self, m):
        self.m = m
        self.node_dict = {}
        self.start_pos = None

    def create_node(self, pos, is_goal=0):
        if pos not in self.node_dict:
            self.node_dict[pos] = Node(pos, is_goal)

    def populate_tree(self):
        X = len(self.m)
        Y = len(self.m[0])
        for x in range(X):
            for y in range(Y):
                if self.m[x][y] == '.' or self.m[x][y] == 'S':
                    self.create_node((x, y))
                    if self.m[x][y] == 'S':
                        self.start_pos = (x, y)
                    for vec in NEIGHBORHOOD:
                        (k, l) = (x+vec[0], y+vec[1])
                        if k in range(X) and l in range(Y):
                            self.create_node((k, l))
                            self.node_dict[(x, y)].add_child(self.node_dict[(k, l)])
                elif self.m[x][y] == 'G':
                    self.create_node((x, y), is_goal=1)

    def find_shortest_path_to_goal(self):
        return self.node_dict[self.start_pos].find_shortest_path_to_goal()


def wire_DHD_SG1(existingWires):
    # create tree
    m = [[l for l in s] for s in existingWires.split()]
    t = Tree(m)
    t.populate_tree()
    path = t.find_shortest_path_to_goal()
    # if Node.possible_paths == []:
    #     return "Oh for crying out loud..."
    # else:
    #     print("toto")
    #     # Node.possible_paths.sort()
    #     # for (a,b) in Node.possible_paths[0][1][1:-1]:
    #     #     m[a][b] = 'P'
    # return "\n".join(["".join(r) for r in m])


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


def gen_input_pattern(n=73):
    s = "S" + (n-1)*"." + "\n"
    for i in range(n-2):
        s += n*"." + "\n"
    s += (n-1)*"."+"G"
    return s


print(wire_DHD_SG1(gen_input_pattern(3)))
