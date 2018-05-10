#!/usr/bin/env python3

'''
We want to generate all the numbers of three digits that:
    the value of adding their corresponding ones(digits) is equal to 10
    their digits are in increasing order (the numbers may have two or more equal contiguous digits)

The numbers that fulfill the two above constraints are: 118, 127, 136, 145, 226, 235, 244, 334

Make a function that receives two arguments:
    the sum of digits value
    the amount of desired digits for the numbers

The function should output an array with three values: [1,2,3]
    1 - the total amount of all these possible numbers
    2 - the minimum number
    3 - the maximum numberwith

The example given above should be:
    find_all(10, 3) == [8, 118, 334]

If we have only one possible number as a solution, it should output a result like the one below:
    find_all(27, 3) == [1, 999, 999]

If there are no possible numbers, the function should output the empty array.
    find_all(84, 4) == []

The number of solutions climbs up when the number of digits increases.
    find_all(35, 6) == [123, 116999, 566666]

Features of the random tests:
    Numbers of tests: 111
    Sum of digits value between 20 and 65
    Amount of digits between 2 and 15
'''

def find_all(sum_dig, digs):
    if sum_dig < digs or sum_dig > 9*digs:
        return []
    smallest = digs*[1]
    for i in range(sum_dig-digs):
        smallest[-(i//8+1)] += 1
    possible_numbers = set()
    possible_numbers.add(list_to_nb(smallest))
    find_others(smallest,possible_numbers)
    return [len(possible_numbers), sorted(possible_numbers)[0],sorted(possible_numbers)[-1]]

def list_to_nb(l):
    return int(''.join(str(c) for c in l))

def find_others(n,possible_numbers):
    transitions = sorted([n.index(d) for d in set(n)])[1:]
    for i, b in enumerate(transitions):
        for a in transitions[:i+1]:
            new_num = sorted(n[:a-1] + [n[a-1]+1] + n[a:b] + [n[b]-1] + n[b+1:])
            nb = list_to_nb(new_num)
            if nb not in possible_numbers:
                possible_numbers.add(nb)
                find_others(new_num,possible_numbers)

# critical case
for i in range(4):
    print(find_all(75,15))

print(find_all(10, 3), [8, 118, 334])
print(find_all(27, 3), [1, 999, 999])
print(find_all(84, 4), [])
print(find_all(35, 6), [123, 116999, 566666])
# print(find_all(35, 7))
