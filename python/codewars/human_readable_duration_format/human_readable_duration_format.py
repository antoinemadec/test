#!/usr/bin/env python3

def format_duration(s):
    if s == 0:
        return "now"
    else:
        arr = []
        div = 1
        for d,u in zip((60,60,24,365,0), ("second","minute","hour","day","year")):
            n = (s//div)%d if d!=0 else s//div
            if n != 0:
                arr = [str(n) + ' ' + u + ("", "s")[n>1]] + arr
            div *= d
        return ' and '.join([', '.join(arr[:-1]), arr[-1]]) if arr[:-1] else arr[-1]

print(format_duration(1))
print(format_duration(62))
print(format_duration(120))
