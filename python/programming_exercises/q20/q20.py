#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Write a program to compute the frequency of the words from the input. The output should output after sorting the key alphanumerically.
    Suppose the following input is supplied to the program:
    New to Python or choosing between Python 2 and Python 3? Read Python 2 or Python 3.
    Then, the output should be:
    2:2
    3.:1
    3?:1
    New:1
    Python:5
    Read:1
    and:1
    between:1
    choosing:1
    or:2
    to:1

Answer:""")

sentence  = input("Enter sentence: ").split(' ')
freq = {}
for word in sentence:
    freq[word] = freq.get(word, 0) + 1

for word in sorted(freq.keys()):
    print("%s:%d" % (word, freq[word]))

