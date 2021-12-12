#!/usr/bin/env python3

import time


class Cave:
    def __init__(self, name: str):
        self.name = name
        self.is_small = name.islower() and name != "start" and name != "end"
        self.connections = []

    def add_connection(self, names: list[str]):
        if self.name == "end":
            return
        for name in names:
            if name != self.name and name != "start":
                self.connections.append(name)


class Paths:
    def __init__(self, lines, p1):
        self.caves: dict[str, Cave] = {}
        self.populate_caves(lines)
        self.p1 = p1
        self.find_paths_cache = {}

    def populate_caves(self, lines):
        for l in lines:
            names = l.split('-')
            for name in names:
                if name not in self.caves:
                    self.caves[name] = Cave(name)
                self.caves[name].add_connection(names)

    def small_cave_condition_is_ok(self, visit_count: dict):
        counts = list(visit_count.values())
        if self.p1:
            if 2 in counts:
                return False
        else:
            if counts and max(counts) > 2 or len([1 for i in counts if i == 2]) > 1:
                return False
        return True

    def find_paths(self, name="start", small_cave_visit_count: dict = {}):
        key = f"{name} {small_cave_visit_count}"
        if key not in self.find_paths_cache:
            cave = self.caves[name]

            # update visit count
            if cave.is_small:
                small_cave_visit_count = small_cave_visit_count.copy()
                small_cave_visit_count[name] = small_cave_visit_count.get(name, 0) + 1

            # call find_paths() recursively if visit_count condition is OK
            paths = [["end"]] if name == "end" else []
            if self.small_cave_condition_is_ok(small_cave_visit_count):
                for connection in cave.connections:
                    for path in self.find_paths(connection, small_cave_visit_count):
                        paths.append([name] + path)
            self.find_paths_cache[key] = paths

        return self.find_paths_cache[key]


def p1(lines):
    paths = Paths(lines, True)
    return len(paths.find_paths())


def p2(lines):
    paths = Paths(lines, False)
    return len(paths.find_paths())


with open('input.txt', 'r') as f:
    lines = [l.strip() for l in f.readlines()]
    t0 = time.time()
    print(p1(lines))
    t1 = time.time()
    print(p2(lines))
    t2 = time.time()
    print(f"part1 {t1-t0:.2f} s")
    print(f"part2 {t2-t1:.2f} s")
