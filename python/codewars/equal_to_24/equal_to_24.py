#!/usr/bin/env python3

from itertools import permutations

l1 = ('+', '-', '*', '/')
l2 = [[op0, op1] for op0 in l1 for op1 in l1]
l3 = [[op0] + op1 for op0 in l1 for op1 in l2]

def insert_parenthesis(base_s, idx0, idx1):
    s = base_s[:idx1] + ')' + base_s[idx1:]
    s = s[:idx0] + '(' + s[idx0:]
    return s

def equal_to_24(a,b,c,d):
    s = set(permutations((str(a),str(b),str(c),str(d))))
    for p in s:
        for ops in l3:
            string = p[0] + ops[0] + p[1] + ops[1] + p[2] + ops[2] + p[3]
            strings = [string]
            s03 = insert_parenthesis(string, 0, 3)
            s0369 = insert_parenthesis(s03, 6, 9)
            strings += [s03]
            strings += [s0369]
            strings += [insert_parenthesis(string, 0, 5)]
            strings += [insert_parenthesis(string, 2, 5)]
            if ops == ['+', '*', '-'] and p == ('1', '1', '1', '13'):
                print(strings)
            for s in strings:
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

print(equal_to_24(1,1,1,13))     # (1+1)*(13-1)
