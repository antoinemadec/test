#!/usr/bin/env python3

'''
Simply put, your interpreter should be able to deal with nested brackets of any level.

And of course, brackets are useless if you cannot use them to repeat a sequence
of movements! Similar to how individual commands can be postfixed by a
non-negative integer to specify how many times to repeat that command, a
sequence of commands grouped by round brackets () should also be repeated n
times provided a non-negative integer is postfixed onto the brackets, like
such:

(SEQUENCE_OF_COMMANDS)n

... is equivalent to ...

SEQUENCE_OF_COMMANDS...SEQUENCE_OF_COMMANDS (repeatedly executed "n" times)

For example, this RS1 program:

F4LF4RF4RF4LF4LF4RF4RF4LF4LF4RF4RF4

... can be rewritten in RS2 as:

F4L(F4RF4RF4LF4L)2F4RF4RF4

Or:

F4L((F4R)2(F4L)2)2(F4R)2F4
'''

import numpy as np
import re

class M():
    def __init__(self):
        self.m = np.ones((1,1),dtype=int)
        self.dir = 0
        self.coord = [0,0]
    def update_coord(self):
        self.coord[-1+(self.dir&1)] += (1,-1)[self.dir == 1 or self.dir == 2]
    def execute(self,cmd):
        while True:
            m = re.match('(?P<before>.*)\((?P<instr>[^()]*)\)(?P<n>\d*)(?P<after>.*)',cmd)
            if m:
                n = int(m.group('n')) if m.group('n') != '' else 1
                cmd = m.group('before') + n*m.group('instr') + m.group('after')
            else:
                break
        for sub_cmd in re.findall('\D\d*', cmd):
            if len(sub_cmd) == 1:
                n = 1
            else:
                n = int(sub_cmd[1:])
            for i in range(n):
                self.update_matrix(sub_cmd[0])
    def update_matrix(self,instr):
        if instr == 'L':
            self.dir = (self.dir + 1) % 4
        elif instr == 'R':
            self.dir = (self.dir - 1) % 4
        else:
            self.update_coord()
            # if coord not in self.m extend it and update coord
            if self.coord[0] not in range(self.m.shape[0]):
                temp = np.zeros((self.m.shape[0]+1,self.m.shape[1]),dtype=int)
                if self.coord[0] == -1:
                    temp[1:,:] = self.m
                    self.coord[0] = 0
                else:
                    temp[:-1,:] = self.m
                self.m = temp
            elif self.coord[1] not in range(self.m.shape[1]):
                temp = np.zeros((self.m.shape[0],self.m.shape[1]+1),dtype=int)
                if self.coord[1] == -1:
                    temp[:,1:] = self.m
                    self.coord[1] = 0
                else:
                    temp[:,:-1] = self.m
                self.m = temp
            # m[coord] = 1
            self.m[self.coord[0],self.coord[1]] = 1
    def display(self):
        return '\r\n'.join([''.join([(' ','*')[self.m[x,y]] \
                for y in range(self.m.shape[1])]) for x in range(self.m.shape[0])])

def execute(cmd):
    m = M()
    m.execute(cmd)
    return m.display()

print(execute("F4L((F4R)2(F4L)2)2(F4R)2F4"))
print(execute("(FFL)4"))
# print(execute('LF5RF3RF3RF7'))
