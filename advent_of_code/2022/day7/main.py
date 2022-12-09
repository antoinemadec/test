#!/usr/bin/env python3

import time


class Node():
    def __init__(self, size=0):
        self.size = size
        self.childs = {}

    def get_total_size(self):
        return self.size + sum([child.get_total_size() for child in self.childs.values()])


class FileStructure:
    def __init__(self):
        self.cwd = '/'
        self.nodes = {}

    def process(self, line: str):
        if line[0:4] == '$ cd':
            self.cd(line[5:])
            self.nodes.setdefault(self.cwd, Node())
        elif line[0] != '$':
            self.update_node(line)

    def cd(self, path):
        if path == '..':
            i = self.cwd.rfind('/')
            self.cwd = self.cwd[0:i] if i>0 else '/'
        elif path == '/':
            self.cwd = '/'
        else:
            if self.cwd[-1] != '/':
                self.cwd += '/'
            self.cwd += path

    def update_node(self, line: str):
        size, name = line.split()
        path = self.cwd + (f"/{name}" if self.cwd[-1] != '/' else name)
        size = int(size) if size.isdecimal() else 0
        self.nodes.setdefault(path, Node(size))
        self.nodes[self.cwd].childs[path] = self.nodes[path]


with open('input.txt', 'r') as f:
    t0 = time.time()
    fs = FileStructure()
    for line in f:
        fs.process(line.strip())
    print(f'ran in {time.time()-t0:.2}s')
    # p1
    t0 = time.time()
    s = 0
    for path, node in fs.nodes.items():
        total_size = node.get_total_size()
        if node.childs and total_size <= 100000:
            s += total_size
    print(s)
    print(f'ran in {time.time()-t0:.2}s')
    # p2
    t0 = time.time()
    unused_space = 70000000 - fs.nodes['/'].get_total_size()
    missing_space = 30000000 - unused_space
    dirs = []
    for path, node in fs.nodes.items():
        total_size = node.get_total_size()
        if node.childs and total_size >= missing_space:
            dirs.append(total_size)
    dirs.sort()
    print(dirs[0])
    print(f'ran in {time.time()-t0:.2}s')
