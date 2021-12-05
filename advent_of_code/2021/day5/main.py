#!/usr/bin/env python3

def get_points_from_line_of_vents(x1, y1, x2, y2, count_diag):
    points = []
    dx = x2-x1
    dy = y2-y1
    if dx == 0:
        ymin = min(y1, y2)
        for i in range(abs(dy)+1):
            points.append((x1, ymin+i))
    elif dy == 0:
        xmin = min(x1, x2)
        for i in range(abs(dx)+1):
            points.append((xmin+i, y1))
    elif count_diag and abs(dx) == abs(dy):
        xinit = min(x1, x2)
        yinit = (y2, y1)[xinit == x1]
        for i in range(abs(dy) + 1):
            points.append((xinit+i, yinit+(i*(-1, 1)[dx == dy])))
    return points


def part(n):
    diagram = {}
    with open('input.txt', 'r') as f:
        lines = f.readlines()
        for x1y1, _, x2y2 in [line.split() for line in lines]:
            coords = [int(n) for n in x1y1.split(',')] + [int(n) for n in x2y2.split(',')]
            for p in get_points_from_line_of_vents(*coords, n > 1): # type: ignore
                diagram[str(p)] = diagram.get(str(p), 0) + 1
    return len([v for v in diagram.values() if v > 1])


print(part(1))
print(part(2))
