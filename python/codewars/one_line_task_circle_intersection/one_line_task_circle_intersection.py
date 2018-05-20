#!/usr/bin/env python3

'''
Given two congruent circles a and b of radius r, return the area of their
intersection rounded down to the nearest integer.

Code Limit : Less than 128 characters.

Example
For c1 = [0, 0], c2 = [7, 0] and r = 5,
the output should be 14.
'''

# A = 2r**2 cos-1(d/2r)-(d/2)*sqrt(4r2-d2)
# A = (r**2)/2(t-sin(t))

# 139
from math import*
def circleIntersection(a,b,r):
    t=2*acos(min(hypot(*[i-j for i,j in zip(a,b)])/2/r,1))
    return int(r*r*(t-sin(t)))

#     d=((a[0]-b[0])**2+(a[1]-b[1])**2)**.5
#     t=2*acos(d/2/r) if d<2*r else 0

# # 159
# from math import *
# def circleIntersection(a,b,r):
#     d=((a[0]-b[0])**2+(a[1]-b[1])**2)**.5
#     t=2*acos(d/2/r) if d<2*r else 0
#     return int(r*r*(t-sin(t)))

# # 160
# import math
# def circleIntersection(a,b,r):
#     d=((a[0]-b[0])**2+(a[1]-b[1])**2)**.5
#     return int(2*r*r*math.acos(d/2/r)-d/2*(4*r*r-d*d)**.5) if d<2*r else 0

print(circleIntersection([0, 0],[7, 0],5),14)
print(circleIntersection([0, 0],[0, 10],10),122)
print(circleIntersection([5, 6],[5, 6],3),28)
print(circleIntersection([-5, 0],[5, 0],3),0)
# # print(circleIntersection([10, 20],[-5, -15],20),15)
# # print(circleIntersection([-7, 13],[-25, -5],17),132)
# # print(circleIntersection([-20, -4],[-40, 29],7),0)
# # print(circleIntersection([38, -18],[46, -29],10),64)
# # print(circleIntersection([-29, 33],[-8, 13],15),5)
