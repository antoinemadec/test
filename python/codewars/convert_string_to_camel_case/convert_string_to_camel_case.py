#!/usr/bin/env python3

"""
Complete the method/function so that it converts dash/underscore delimited
words into camel casing. The first word within the output should be capitalized
only if the original word was capitalized.
Examples

to_camel_case("the-stealth-warrior") # returns "theStealthWarrior"

to_camel_case("The_Stealth_Warrior") # returns "TheStealthWarrior"
"""

def to_camel_case(text):
    return text[0] + ''.join([w[0].upper() + w[1:] for w in text.replace('-','_').split('_')])[1:] if text else ''


print(to_camel_case("the-stealth-warrior")) # returns "theStealthWarrior"
print(to_camel_case("The_Stealth_Warrior")) # returns "TheStealthWarrior"
print(to_camel_case("")) # returns ""
