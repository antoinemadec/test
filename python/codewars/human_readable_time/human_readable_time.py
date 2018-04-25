#!/usr/bin/env python3

"""
Write a function, which takes a non-negative integer (seconds) as input and returns the time in a human-readable format (HH:MM:SS)

    HH = hours, padded to 2 digits, range: 00 - 99
    MM = minutes, padded to 2 digits, range: 00 - 59
    SS = seconds, padded to 2 digits, range: 00 - 59

The maximum time never exceeds 359999 (99:59:59)
"""

def make_readable(sec):
    h = sec // 3600
    sec -= 3600*h
    m = sec // 60
    sec -= 60*m
    return '%02d:%02d:%02d' % (h,m,sec)

print(make_readable(5))
print(make_readable(86399))
