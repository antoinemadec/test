#!/usr/bin/env python3

class Ccy:
    currencies = {'EUR': 1.0, 'USD': 1.11123458162018}

    def __init__(self, val, cur):
        self.val = val
        self.cur = cur

    def changeTo(self, new_cur):
        self.val = self.val*type(self).currencies[new_cur]/type(self).currencies[self.cur]
        self.cur = new_cur

    def copy(self):
        return type(self)(self.val, self.cur)

    def __str__(self):
        return "%.2f %s" % (self.val, self.cur)

    def __add__(self, other):
        if type(other) == int or type(other) == float:
            val = other
        else:
            obj = other.copy()
            obj.changeTo(self.cur)
            val = obj.val
        return Ccy(self.val + val, self.cur)

    def __radd__(self, other):
        return self + other

    def __mul__(self, other):
        if type(other) == int or type(other) == float:
            val = other
        else:
            obj = other.copy()
            obj.changeTo(self.cur)
            val = obj.val
            print("DBG: val=%.2f" % val)
        return Ccy(self.val * val, self.cur)

    def __rmul__(self, other):
        return self * other


v1 = Ccy(23.43, "EUR")
v2 = Ccy(19.97, "USD")
print("v1= %s" % v1)
print("v2= %s" % v2)
print("v1+v2= %s" % (v1 + v2))
print("v2+v1= %s" % (v2 + v1))
print("v1+3= %s" % (v1 + 3)) # an int or a float is considered to be a EUR value
print("3+v2= %s" %  (3 + v2))
print("v1*v2= %s" % (v1 * v2))
print("v2*v1= %s" % (v2 * v1))
print("v1*3= %s" % (v1 * 3)) # an int or a float is considered to be a EUR value
print("3*v2= %s" %  (3 * v2))
