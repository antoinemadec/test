#!/usr/bin/env python3

"""
You are given an array strarr of strings and an integer k. Your task is to
return the first longest string consisting of k consecutive strings taken in
the array.

#Example: longest_consec(["zone", "abigail", "theta", "form", "libe", "zas",
"theta", "abigail"], 2) --> "abigailtheta"

n being the length of the string array, if n = 0 or k > n or k <= 0 return "".
"""


def longest_consec(strarr, k):
    consec_arr = [''.join(strarr[i:i+k]) for i in range(len(strarr)-k+1)]
    len_arr = [len(w) for w in consec_arr]
    return consec_arr[len_arr.index(max(len_arr))] if k>=0 and len_arr else ""

print(longest_consec(["zone", "abigail", "theta", "form", "libe", "zas"], 2))
print(longest_consec(["zone", "abigail", "theta", "form", "libe", "zas"], 4))
print(longest_consec([], 2))
print(longest_consec(["zone", "abigail", "theta"], 3))
print(longest_consec(["zone", "abigail", "theta"], 2))
print(longest_consec(["zone", "abigail", "theta"], 4))
print(longest_consec(["zone", "abigail", "theta"], -1))
