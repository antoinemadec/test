#!/usr/bin/env python

"""
Alright, detective, one of our colleagues successfully observed our target
person, Robby the robber. We followed him to a secret warehouse, where we
assume to find all the stolen stuff. The door to this warehouse is secured by
an electronic combination lock. Unfortunately our spy isn't sure about the PIN
he saw, when Robby entered it.

The keypad has the following layout:

 1  2  3
 4  5  6
 7  8  9
    0

He noted the PIN 1357, but he also said, it is possible that each of the digits
he saw could actually be another adjacent digit (horizontally or vertically,
but not diagonally). E.g. instead of the 1 it could also be the 2 or 4. And
instead of the 5 it could also be the 2, 4, 6 or 8.

He also mentioned, he knows this kind of locks. You can enter an unlimited
amount of wrong PINs, they never finally lock the system or sound the alarm.
That's why we can try out all possible (*) variations.

* possible in sense of: the observed PIN itself and all variations considering the adjacent digits

Can you help us to find all those variations? It would be nice to have a
function, that returns an array of all variations for an observed PIN with a
length of 1 to 8 digits. We could name the function getPINs (get_pins in
python). But please note that all PINs, the observed one and also the results,
must be strings, because of potentially leading '0's. We already prepared some
test cases for you.

Detective, we count on you!
"""

# TODO: overkill, just list them manually
possible_keys = {}
possible_keys[0] = [0,8]
for i in range(1,10):
    x,y = (i-1)//3, (i-1)%3
    arr = []
    for X, Y in ((x-1,y), (x,y-1), (x,y), (x,y+1), (x+1,y)):
        if X in range(3) and Y in range(3):
            arr.append(X*3+Y+1)
    if i == 8:
        arr.append(0)
    possible_keys[i] = arr

# TODO: could be done in one line with itertools.product
# TODO: could be done more nicely with proper recursion
combinations = []
def get_pins_recursion(numbers):
    if numbers:
        global combinations
        new_combinations = []
        for i in possible_keys[numbers[0]]:
            if combinations:
                new_combinations += (a + [i] for a in combinations)
            else:
                new_combinations.append([i])
        combinations = new_combinations
        get_pins_recursion(numbers[1:])

def get_pins(observed):
    global combinations
    combinations = []
    get_pins_recursion([int(c) for c in observed])
    return [''.join([str(n) for n in a]) for a in combinations]

# print(sorted(get_pins('11')))

expectations = [('8', ['5','7','8','9','0']),
        ('11',["11", "22", "44", "12", "21", "14", "41", "24", "42"]),
        ('369', ["339","366","399","658","636","258","268","669","668","266","369","398","256","296","259","368","638","396","238","356","659","639","666","359","336","299","338","696","269","358","656","698","699","298","236","239"])]

for tup in expectations:
    print(sorted(get_pins(tup[0])))
    print(sorted(tup[1]))
