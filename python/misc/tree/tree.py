#!/usr/bin/env python3

from functools import lru_cache

class Node:
    def __init__(self, name):
        self.name = name
        self.child_weight_list: [(Node, int)] = []

    def add_child(self, child: 'Node', weight: int):
        self.child_weight_list.append((child, weight))

    @lru_cache(maxsize=None)    
    def find_heaviest_branch(self) -> (int, str):
        if not self.child_weight_list:
            return (0, self.name)
        else:
            max_weight = 0
            max_weight_str = ""
            for child, child_weight in self.child_weight_list:
                (branch_weight, branch_str) = child.find_heaviest_branch()
                total_weight = child_weight + branch_weight
                if total_weight > max_weight:
                    max_weight = total_weight
                    max_weight_str = f"{self.name}->{branch_str}" 
            return (max_weight, max_weight_str)


class Tree(object):
    def __init__(self, filename):
        self.nodes = {}
        self.create_tree_from_file(filename)

    def create_tree_from_file(self, filename):
        with open("./tree.txt", 'r') as fp:
            for line in fp:
                line = line.strip()
                parent_name = line[0]
                if parent_name not in self.nodes:
                    self.nodes[parent_name] = Node(parent_name)
                idx = 3
                while idx < len(line):
                    child_name = line[idx]
                    weight = line[idx+1]
                    idx += 3
                    if child_name not in self.nodes:
                        self.nodes[child_name] = Node(child_name)
                    self.nodes[parent_name].add_child(self.nodes[child_name], int(weight))



if __name__ == "__main__":
    t = Tree("./tree.txt")
    (w, s) = t.nodes['A'].find_heaviest_branch()
    print(w, s)
