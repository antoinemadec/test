#!/usr/bin/env python3

def getCount(inputStr):
    num_vowels = 0
    for c in inputStr:
        if c in "aeiou":
            num_vowels += 1
    return num_vowels

print(getCount("antoine"))
