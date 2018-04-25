#!/usr/bin/env python3

class Human:
    pass

class Man(Human):
    pass

class Woman(Human):
    pass

def God():
    return (Man(), Woman())

paradise = God()
print(paradise[0])
print(paradise[1])
