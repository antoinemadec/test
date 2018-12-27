#!/usr/bin/env python3

f = {}
def factorial(n):
    if n==0:
        f[n] = 1
    elif n not in f:
        f[n] = n*factorial(n-1)
    return f[n]

def factoradics(n):
    for k in range(n+2):
        if factorial(k) > n:
            break
    r = []
    for k in range(k-1,-1,-1):
        d = n//factorial(k)
        r.append(d)
        n -= d*factorial(k)
    return r if r else [0]

# https://medium.com/@aiswaryamathur/find-the-n-th-permutation-of-an-ordered-string-using-factorial-number-system-9c81e34ab0c8
def middle_permutation(string):
    string  = sorted(string)
    i       = factorial(len(string))//2 - 1
    r       = ""
    for k in factoradics(i):
        r += string[k]
        string = string[:k] + string[k+1:]
    return r+''.join(string)

print(middle_permutation("ab"),"ab")
print(middle_permutation("abc"),"bac")
print(middle_permutation("abcd"),"bdca")
print(middle_permutation("abcdx"),"cbxda")
print(middle_permutation("abcdxg"),"cxgdba")
print(middle_permutation("abcdxgz"),"dczxgba")
print(middle_permutation("abcdefghijklmnopqrstuvwxyz"))
