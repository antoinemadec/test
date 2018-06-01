#!/usr/bin/env python3

'''
You are given a list/array of example formulas such as:
[ "a + a = b", "b - d = c ", "a + b = d" ]

Use this information to solve a formula in terms of the remaining symbol such as:
"c + a + b" = ?

in this example:
"c + a + b" = "2a"

Notes:
    Variables names are case sensitive
    There might be whitespaces between the different characters. Or not...
    There should be support for parenthesis and their coefficient. Example: a +
    3 (6b - c).
    You might encounter several imbricated levels of parenthesis but you'll
    never get a variable as coefficient for parenthesis, only constant terms.
    All equations will be linear

See the sample tests for clarification of what exactly the input/ouput formatting should be.

Without giving away too many hints, the idea is to substitute the examples into
the formula and reduce the resulting equation to one unique term. Look
carefully at the example tests: you'll have to identify the pattern used to
replace variables in the formula/other equations. Only one solution is possible
for each test, using this pattern, so if you keep asking yourself "but what if
I do that instead of...", that is you missed the thing.
'''

import re

def simplify(examples,formula):
    d,letters = {},[]
    examples = [re.sub('([0-9]+) *([(a-zA-Z])',r'\1*\2',e) for e in examples]
    for e in examples:
        m = re.match('(?P<expr>.*) += +(?P<var>\w+)',e)
        d[m.group('var')] = m.group('expr')
        letters.extend([c for c in e if c.isalpha()])
    c = [c for c in letters if c not in d][0]
    d[c] = '1'
    for _ in range(1000):
        formula = re.sub('([0-9]+) *([(a-zA-Z])',r'\1*\2',formula)
        for k in d:
            formula = formula.replace(k,'(' + d[k] + ')')
        try:
            r = eval(formula)
        except:
            continue
        return "%d%c" % (r,c)

examples=[["a + a = b", "b - d = c", "a + b = d"],
        ["a + 3g = k", "-70a = g"],
        ["-j -j -j + j = b"]]
formula=["c + a + b",
        "-k + a",
        "-j - b"
        ]
answer=["2a",
        "210a",
        "1j"
        ]

for i in range(len(answer)):
    print('examples:' + str(examples[i]))
    print('formula:' + str(formula[i]))
    print('expected answer:'+str(answer[i]))
    print(simplify(examples[i],formula[i]))
examples=['y + 6Y - k - 6 K = f', ' F + k + Y - y = K', 'Y = k', 'y = Y', 'y + Y = F']
formula='k - f + y'
print('expected answer:14y')
print(simplify(examples,formula))

examples=['x = b', 'b = c', 'c = d', 'd = e']
formula='c'
print('expected answer:1x')
print(simplify(examples,formula))
