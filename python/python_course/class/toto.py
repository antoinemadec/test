#!/usr/bin/env python3

class Person:
    def __init__(self, fn, ln):
        self.firstname = fn
        self.lastname = ln

    def Name(self):
        return "%s %s" % (self.firstname, self.lastname)

class Employee(Person):
    def __init__(self, fn, ln, staffnum):
        super().__init__(fn, ln)
        self.staffnumber = staffnum

    def GetEmployee(self):
        return self.Name() + " " + self.staffnumber

x = Person("Marge", "Simpson")
y = Employee("Homer", "Simpson", "1007")

print(x.Name())
print(y.GetEmployee())
