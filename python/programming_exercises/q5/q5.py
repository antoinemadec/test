#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    Define a class which has at least two methods:
    getString: to get a string from console input
    printString: to print the string in upper case.
    Also please include simple test function to test the class methods.

Answer:""")

class String:
    def __init__(self):
        self.string = ""
    def getString(self):
        self.string = input("Enter string: ")
    def printString(self):
        print(self.string.upper())

s = String();
s.getString()
s.printString()
