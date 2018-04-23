#!/usr/bin/env python3

def fizz_buzz_reloaded(start, stop, step, functions):
    """
    >>> fizz_buzz_reloaded(15, 3, -4, {"flash": lambda x: x % 3 == 0, "bang" : lambda x: x % 5 == 0})
    "flashbang 11 7 flash"
    """
    strings = []
    for x in range(start, stop + (-1,1)[step>0), step):
        print(x)
        s = ""
        for (k, f) in functions.items():
            if f(x):
                s += k
        strings.append((s,str(x))[s == ""])
    return " ".join(strings)

s = fizz_buzz_reloaded(15, 3, -4, {"flash": lambda x: x % 3 == 0, "bang" : lambda x: x % 5 == 0})
print(s)
