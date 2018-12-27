#!/usr/bin/env python3

"""
Write a function that takes a string of braces, and determines if the order of
the braces is valid. It should return true if the string is valid, and false if
it's invalid.

This Kata is similar to the Valid Parentheses Kata, but introduces new
characters: brackets [], and curly braces {}. Thanks to @arnedag for the idea!

All input strings will be nonempty, and will only consist of parentheses,
brackets and curly braces: ()[]{}.  What is considered Valid?

A string of braces is considered valid if all braces are matched with the
correct brace.
Examples

"(){}[]"   =>  True
"([{}])"   =>  True
"(}"       =>  False
"[(])"     =>  False
"[({})](]" =>  False

"""

def validBraces(s):
  while '{}' in s or '()' in s or '[]' in s:
      s=s.replace('{}','')
      s=s.replace('[]','')
      s=s.replace('()','')
  return s==''

# symbols = ['(','{','[',')','}',']']

# def validBraces(s):
#     counts = [0,0,0]
#     open_index = []
#     for i in [symbols.index(c) for c in s if c in symbols]:
#         if i<3:
#             counts[i%3] += 1
#             open_index.append(i%3)
#         else:
#             counts[i%3] -= 1
#             if counts[i%3] < 0 or i%3 != open_index.pop():
#                 return False
#     return sum(counts) == 0


print(validBraces("(){}[]"))
print(validBraces("([{}])"))
print(validBraces("(}"))
print(validBraces("[(])"))
print(validBraces("[({})](]"))
