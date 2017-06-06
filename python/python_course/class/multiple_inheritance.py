#!/usr/bin/env python3

class A:
    def m(self):
        print("m of A called")

class B(A):
    def m(self):
        print("m of B called")
        super().m()

class C(A):
    def m(self):
        print("m of C called")
        super().m()

class D(B,C):
    def m(self):
        print("m of D called")
        super().m()

a=A()
b=B()
c=C()
d=D()
print("-- a.m()")
a.m()
print("-- b.m()")
b.m()
print("-- c.m()")
c.m()
print("-- d.m()")
d.m()
print("-- A.m(d)")
A.m(d)
print("-- D.mro()")
print(D.mro())
