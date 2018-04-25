#!/usr/bin/env python3

def find_missing_letter(chars):
    exp_uni = ord(chars[0]) + 1
    for c in chars[1:]:
        if ord(c) != exp_uni:
            return chr(exp_uni)
        else:
            exp_uni += 1

print(find_missing_letter(['a','b','c','d','f']))
