#!/usr/bin/env python3

def get_line_first_error(line):
    conv = {
        '(': ')',
        '[': ']',
        '{': '}',
        '<': '>',
    }
    stack = []
    for c in line:
        if c in "{[(<":
            stack.append(c)
        else:
            e = stack.pop(-1)
            if c != conv[e]:
                return (c, stack)
    return (None, stack)


def p1(lines):
    points = {
        ')': 3,
        ']': 57,
        '}': 1197,
        '>': 25137,
    }
    s = 0
    for l in lines:
        error, _ = get_line_first_error(l)
        if error:
            s += points[error]
    return s


def p2(lines):
    points = {
        '(': 1,
        '[': 2,
        '{': 3,
        '<': 4,
    }
    scores = []
    for l in lines:
        score = 0
        error, stack = get_line_first_error(l)
        if not error:
            while len(stack):
                score *= 5
                score += points[stack.pop(-1)]
            scores.append(score)
    return sorted(scores)[len(scores)//2]


with open('input.txt', 'r') as f:
    lines = [l.strip() for l in f.readlines()]
    print(p1(lines))
    print(p2(lines))
