"""This module implement fibo functions

You can choose between recursive or iterative implementation.
"""

import time

__all__ = ["fib", "ifib"]
__version__ = "1.0"

def timing_decorator(f):
    def wrap(*a):
        t1 = time.time()
        r = f(*a)
        t2 = time.time()
        print("%s took %0.3f s" % (f.__name__, (t2-t1)))
        return r
    return wrap

mem = {0:0, 1:1}

@timing_decorator
def fib(n):
    return fib_core(n)

def fib_core(n):
    if n not in mem:
        mem[n] = fib_core(n-1) + fib_core(n-2)
    return mem[n]

@timing_decorator
def ifib(n):
    a, b = 0, 1
    for i in range(n):
        a, b = b, a + b
    return a
