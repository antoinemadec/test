#!/usr/bin/env python3

from itertools import permutations

l1 = ('+', '-', '*', '/')
l2 = [[op0, op1] for op0 in l1 for op1 in l1]
l3 = [[op0] + op1 for op0 in l1 for op1 in l2]

def insert_parenthesis(base_l, idx0, idx1):
    cpy_l = base_l[:]
    cpy_l.insert(idx1, ')')
    cpy_l.insert(idx0, '(')
    return cpy_l

def equal_to_24(a,b,c,d):
    s = set(permutations((str(a),str(b),str(c),str(d))))
    for p in s:
        for ops in l3:
            l_str = [p[0], ops[0], p[1], ops[1], p[2], ops[2], p[3]]
            l_strs = [l_str]
            l_s03 = insert_parenthesis(l_str, 0, 3)
            l_s0369 = insert_parenthesis(l_s03, 6, 9)
            l_strs += [l_s03]
            l_strs += [l_s0369]
            l_strs += [insert_parenthesis(l_str, 0, 5)]
            l_strs += [insert_parenthesis(l_str, 2, 5)]
            for l_s in l_strs:
                s = "".join(l_s)
                try:
                    if eval(s) == 24:
                        return s
                except:
                    pass
    return "It's not possible!"

# print(equal_to_24(1,2,3,4))     # can return "(1+3)*(2+4)" or "1*2*3*4"
# print(equal_to_24(2,3,4,5))     # can return "(5+3-2)*4" or "(3+4+5)*2"
# print(equal_to_24(3,4,5,6))     # can return "(3-4+5)*6"
# print(equal_to_24(1,1,1,1))     # should return "It's not possible!"
# print(equal_to_24(13,13,13,13)) # should return "It's not possible!"

print(equal_to_24(1,1,1,13))    # (1+1)*(13-1)
print(equal_to_24(1,3,4,6))     # 6/(1-(3/4))
