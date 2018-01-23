#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:

    Please write a program to compress and decompress the string "hello world!hello world!hello world!hello world!".



Answer:""")

import zlib

s = 'hello world!hello world!hello world!hello world!'
c = zlib.compress(str.encode(s))
print(c)
print(zlib.decompress(c))
