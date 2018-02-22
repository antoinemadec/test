#!/bin/env python3

class PointWithDistance:
    def __init__(self, coord):
        self.coord = coord
        self.dist2 = coord[0]**2 + coord[1]**2

    def __str__(self):
        return "(%d,%d) d=%.2f" % (self.coord[0], self.coord[1], self.dist2**0.5)

    __repr__ = __str__


#execution
points = [(-2,4), (0,-2), (-1,0), (3,5), (-2,-3), (3,2)]
K = 3

points_with_distance = []
for p in points:
    pd = PointWithDistance(p)
    n  = len(points_with_distance)
    if n == 0:
        points_with_distance.append(pd)
    else:
        for i in range(0,n):
            if pd.dist2 < points_with_distance[i].dist2:
                points_with_distance.insert(i,pd)
                del points_with_distance[K:]
                break

print(points_with_distance)
