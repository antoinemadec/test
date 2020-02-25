#!/usr/bin/env python3

class Foo:
    static_var = 0

    def __init__(self, foo):
        self.foo = foo

    def print(self):
        print("static_var={0} foo={1}".format(self.static_var, self.foo))

f0 = Foo(42)
f1 = Foo(29)

Foo.static_var = 7
f0.print()
f1.print()
