#!/usr/bin/env python3

print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
        Python has many built-in functions, and if you do not know how to use it, you can read document online or find some books. But Python has a built-in document function for every built-in functions.
        Please write a program to print some Python built-in functions documents, such as abs(), int(), raw_input()
        And add document for your own function

Answer:""")

def myFunc():
    """This is myFunc's doc."""
    print("FOO")

print("\n---- tuple doc:\n" + tuple.__doc__)
print("\n---- myFunc doc:\n" + myFunc.__doc__)
