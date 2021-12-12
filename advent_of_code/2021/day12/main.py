#!/usr/bin/env python3

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

    def populate_caves(self, lines):
        for l in lines:
            names = l.split('-')
            for name in l.split('-'):
                if name not in self.caves:
                    self.caves[name] = Cave(name)
                self.caves[name].add_connection(names)

    def small_cave_condition_is_ok(self, visit_count: dict):
        counts = list(visit_count.values())
        if self.p1:
            if 2 in counts:
                return False
        else:
            if counts and max(counts) > 2:
                return False
            else:
                if 2 in counts:
                    counts.pop(counts.index(2))
                if 2 in counts:
                    return False
        return True

    def find_paths(self, name="start", small_cave_visit_count: dict = {}):
        # update visit count
        if self.caves[name].is_small:
            small_cave_visit_count[name] = small_cave_visit_count.get(
                name, 0) + 1

        # call find_paths() recursively if visit_count condition is OK
        if self.small_cave_condition_is_ok(small_cave_visit_count):
            paths = [[name]] if name == "end" else []
            for connection in self.caves[name].connections:
                for path in self.find_paths(connection, small_cave_visit_count.copy()):
                    new_path = [name] + path
                    paths.append(new_path)
            return paths
        else:
            return []


def p1(lines):
    paths = Paths(lines, True)
    return len(paths.find_paths())


def p2(lines):
    paths = Paths(lines, False)
    return len(paths.find_paths())


with open('input.txt', 'r') as f:
    lines = [l.strip() for l in f.readlines()]
    print(p1(lines))
    print(p2(lines))
