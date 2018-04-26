#!/usr/bin/env python3

"""
You have to create a function that takes a positive integer number and returns
the next bigger number formed by the same digits:

next_bigger(12)==21
next_bigger(513)==531
next_bigger(2017)==2071

If no bigger number can be composed using those digits, return -1:

next_bigger(9)==-1
next_bigger(111)==-1
next_bigger(531)==-1
"""

#--------------------------------------------------------------
# not efficent enough (recursion)
#--------------------------------------------------------------
class StrPermRecursion:
    def __init__(self, string):
        self.perms = []
        self.perm_core("", string)
    def perm_core(self, string, pool):
        if pool:
            for i in range(len(pool)):
                self.perm_core(string + pool[i:i+1], pool[:i] + pool[i+1:])
        else:
            self.perms.append(string)

def compute_perm(string):
    string_pool = [("",string)]
    perms = []
    while len(string_pool):
        (string,pool) = string_pool.pop()
        if not pool:
            perms.append(string)
        else:
            for i in range(len(pool)):
                string_pool.insert(0, (string + pool[i:i+1], pool[:i] + pool[i+1:]))
    return perms


def all_perms(elements):
    if len(elements) <=1:
        yield elements
    else:
        for perm in all_perms(elements[1:]):
            for i in range(len(elements)):
                # nb elements[0:1] works in both string and list contexts
                yield perm[:i] + elements[0:1] + perm[i:]
#--------------------------------------------------------------

# def next_bigger(n):
#     perms = list(sorted(set([int(s) for s in StrPermRecursion(str(n)).perms])))
#     # perms = list(sorted(set([int(s) for s in all_perms(str(n))])))
#     # perms = list(sorted(set([int(s) for s in compute_perm(str(n))])))
#     nb_i = perms.index(n) + 1
#     return perms[nb_i] if nb_i<len(perms) else -1

def next_bigger(n):
    s = list(str(n))
    for i in range(len(s)-2,-1,-1):
        if s[i] < s[i+1]:
            t = s[i:]
            m = min(filter(lambda x: x>t[0], t))
            t.remove(m)
            t.sort()
            s[i:] = [m] + t
            return int("".join(s))
    return -1


print(next_bigger(123))
print(next_bigger(111))
print(next_bigger(123456))
print(next_bigger(1234567891))
