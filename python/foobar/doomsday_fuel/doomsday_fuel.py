#!/usr/bin/env python


# bad solution, see that page instead:
#   https://en.wikipedia.org/wiki/Absorbing_Markov_chain

"""
Doomsday Fuel
=============

Making fuel for the LAMBCHOP's reactor core is a tricky process because of the
exotic matter involved. It starts as raw ore, then during processing, begins
randomly changing between forms, eventually reaching a stable form. There may
be multiple stable forms that a sample could ultimately reach, not all of which
are useful as fuel.

Commander Lambda has tasked you to help the scientists increase fuel creation
efficiency by predicting the end state of a given ore sample. You have
carefully studied the different structures that the ore can take and which
transitions it undergoes. It appears that, while random, the probability of
each structure transforming is fixed. That is, each time the ore is in 1 state,
it has the same probabilities of entering the next state (which might be the
same state).  You have recorded the observed transitions in a matrix. The
others in the lab have hypothesized more exotic forms that the ore can become,
but you haven't seen all of them.

Write a function answer(m) that takes an array of array of nonnegative ints
representing how many times that state has gone to the next state and return an
array of ints for each terminal state giving the exact probabilities of each
terminal state, represented as the numerator for each state, then the
denominator for all of them at the end and in simplest form. The matrix is at
most 10 by 10. It is guaranteed that no matter which state the ore is in, there
is a path from that state to a terminal state. That is, the processing will
always eventually end in a stable state. The ore starts in state 0. The
denominator will fit within a signed 32-bit integer during the calculation, as
long as the fraction is simplified regularly.

For example, consider the matrix m:
[
  [0,1,0,0,0,1],  # s0, the initial state, goes to s1 and s5 with equal probability
  [4,0,0,3,2,0],  # s1 can become s0, s3, or s4, but with different probabilities
  [0,0,0,0,0,0],  # s2 is terminal, and unreachable (never observed in practice)
  [0,0,0,0,0,0],  # s3 is terminal
  [0,0,0,0,0,0],  # s4 is terminal
  [0,0,0,0,0,0],  # s5 is terminal
]
So, we can consider different paths to terminal states, such as:
s0 -> s1 -> s3
s0 -> s1 -> s0 -> s1 -> s0 -> s1 -> s4
s0 -> s1 -> s0 -> s5
Tracing the probabilities of each, we find that
s2 has probability 0
s3 has probability 3/14
s4 has probability 1/7
s5 has probability 9/14
So, putting that together, and making a common denominator, gives an answer in the form of
[s2.numerator, s3.numerator, s4.numerator, s5.numerator, denominator] which is
[0, 3, 2, 9, 14].

Languages
=========

To provide a Python solution, edit solution.py
To provide a Java solution, edit solution.java

Test cases
==========

Inputs:
    (int) m = [[0, 2, 1, 0, 0], [0, 0, 0, 3, 4], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
Output:
    (int list) [7, 6, 8, 21]

Inputs:
    (int) m = [[0, 1, 0, 0, 0, 1], [4, 0, 0, 3, 2, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]]
Output:
    (int list) [0, 3, 2, 9, 14]

Use verify [file] to test your solution and see how it does. When you are
finished editing your code, use submit [file] to submit your answer. If your
solution passes the test cases, it will be removed from your home folder.
"""


MAX_DENOMINATOR=(2**31)-1

import cProfile

from fractions import Fraction, gcd

def lcm(a, b):
    return a * b / gcd(a, b)

class Tree:
    def __init__(self, m):
        self.final_probabilities = {}
        self.nodes = [Node(i) for i in range(len(m))]
        for i, a in enumerate(m):
            denominator = sum(a)
            if denominator == 0:
                self.final_probabilities[i] = []
            for j, numerator in enumerate(a):
                if numerator != 0:
                    self.nodes[i].add_child(self.nodes[j], numerator, denominator)

    def get_probabilities(self):
        self.nodes[0].compute_branches(self)
        for k in self.final_probabilities.keys():
            s = Fraction(0)
            for n,d in self.final_probabilities[k]:
                s = (s + Fraction(n,d)).limit_denominator(MAX_DENOMINATOR)
            self.final_probabilities[k] = s
        return self.final_probabilities

class Node:
    def __init__(self, state):
        self.state = state
        self.children = []

    def add_child(self, obj, numerator, denominator):
        self.children.append((obj, numerator, denominator))

    def compute_branches(self, tree, n=1, d=1, prof=0):
        if not self.children:
            tree.final_probabilities[self.state].append((n,d))
        for obj, numerator, denominator in self.children:
            if d > MAX_DENOMINATOR:
                f = Fraction(n,d)
                n,d = f.numerator, f.denominator
            if n != 0 and d <= MAX_DENOMINATOR:
                obj.compute_branches(tree, n*numerator, d*denominator, prof+1)

def answer(m):
    t = Tree(m)
    # compute final state probabilities
    final_p_dict = t.get_probabilities()
    final_p      = [final_p_dict[k] for k in sorted(final_p_dict.keys())]
    # find common denom
    common_d = 1
    for i,f in enumerate(final_p):
        d = f.denominator
        common_d = int(lcm(common_d, d))
    return [int(f.numerator*(common_d/f.denominator)) for f in final_p] + [common_d]




def test():
    answer(gen_arr(3))
    # for i in range (1000):
    #     answer([[0,1,0,0,0,1], [4,0,0,3,2,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]])

def gen_arr(n):
    return (n-1)*[n*[1]] + [n*[0]]

# print(answer(gen_arr(2)))
# print(answer(gen_arr(3)))
# print(answer(gen_arr(4)))

# cProfile.run('test()')
# print(answer([[0, 2, 1, 0, 0], [0, 0, 0, 3, 4], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]))
print(answer([[0,1,0,0,0,1], [4,0,0,3,2,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]))
