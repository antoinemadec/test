#!/usr/bin/env python3

'''
Consider a "word" as any sequence of capital letters A-Z (not limited to just
"dictionary words"). For any word with at least two different letters, there
are other words composed of the same letters but in a different order (for
instance, STATIONARILY/ANTIROYALIST, which happen to both be dictionary words;
for our purposes "AAIILNORSTTY" is also a "word" composed of the same letters
as these two).

We can then assign a number to every word, based on where it falls in an
alphabetically sorted list of all words made up of the same group of letters.
One way to do this would be to generate the entire list of words and find the
desired one, but this would be slow if the word is long.

Given a word, return its number. Your function should be able to accept any
word 25 letters or less in length (possibly with some letters repeated), and
take no more than 500 milliseconds to run. To compare, when the solution code
runs the 27 test cases in JS, it takes 101ms.

For very large words, you'll run into number precision issues in JS (if the
word's position is greater than 2^53). For the JS tests with large positions,
there's some leeway (.000000001%). If you feel like you're getting it right for
the smaller ranks, and only failing by rounding on the larger, submit a couple
more times and see if it takes.

Python, Java and Haskell have arbitrary integer precision, so you must be
precise in those languages (unless someone corrects me).

C# is using a long, which may not have the best precision, but the tests are
locked so we can't change it.

Sample words, with their rank:
ABAB = 2
AAAB = 1
BAAA = 4
QUESTION = 24572
BOOKKEEPER = 10743
'''

def listPosition(word):
    pass

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
def nth_permutation(string,n):
    string  = sorted(string)
    r       = ""
    fr_n = factoradics(n)
    fr_n = (len(string) - len(fr_n))*[0] + fr_n
    for k in fr_n:
        r += string[k]
        string = string[:k] + string[k+1:]
    return r+''.join(string)

# print(listPosition('A'), 1)
# print(listPosition('ABAB'), 2)
# print(listPosition('AAAB'), 1)
# print(listPosition('BAAA'), 4)
# print(listPosition('QUESTION'), 24572)
# print(listPosition('BOOKKEEPER'), 10743)

for i in range(4*3*2):
    print(str(i), nth_permutation('abcd',i))
