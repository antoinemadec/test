#!/bin/env python3


def find_multiple(int_list, multiple):
    sorted_list = sorted(int_list)
    n = len(sorted_list)
    for i in range(0,n):
        for j in range(i+1,n):
            x = sorted_list[i]
            y = sorted_list[j]
            if x*y == multiple:
                return (x,y)
            elif x>multiple:
                return None
    return None


# execution
l = [int(x) for x in input("Enter list (white space separated): ").split(" ")]
m = int(input("Enter multiple: "))
print(find_multiple(l,m))
