#!/usr/bin/env python3

def get_second_max(l):
    assert len(l) >= 2, "get_second_max list size must be >= 2"
    max_0 = l[0];
    max_1 = l[0];
    for e in l:
        if e > max_0:
            (max_0, max_1) = (e, max_0)
        elif e > max_1:
            max_1 = e
    return max_1

# execution
l = (1,2,0,5,3,4)
print(get_second_max(l))
