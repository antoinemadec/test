#!/usr/bin/env python3

from operator import itemgetter


print("""https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt

Question:
    You are required to write a program to sort the (name, age, height) tuples by ascending order where name is string, age and height are numbers. The tuples are input by console. The sort criteria is:
    1: Sort based on name;
    2: Then sort based on age;
    3: Then sort by score.
    The priority is that name > age > score.
    If the following tuples are given as input to the program:
    Tom,19,80
    John,20,90
    Jony,17,91
    Jony,17,93
    Json,21,85
    Then, the output of the program should be:
    [('John', '20', '90'), ('Jony', '17', '91'), ('Jony', '17', '93'), ('Json', '21', '85'), ('Tom', '19', '80')]

Answer:""")

l = []
while True:
    t = input("")
    if t == "":
        break
    l.append(tuple(t.split(',')))
l.sort(key=itemgetter(0,1,2))
print(l)
