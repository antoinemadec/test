#!/usr/bin/env python3

'''
Write an interpreter for RS1 called execute() which accepts 1 required argument
code, the RS1 program to be executed. The interpreter should return a string
representation of the smallest 2D grid containing the full path that the
MyRobot has walked on (explained in more detail later).

Initially, the robot starts at the middle of a 1x1 grid. Everywhere the robot
walks it will leave a path "*". If the robot has not been at a particular point
on the grid then that point will be represented by a whitespace character " ".
So if the RS1 program passed in to execute() is empty then:

execute(""); // => "*"

The robot understand 3 major commands:
    F - Move forward by 1 step in the direction that it is currently pointing. Initially, the robot faces to the right.
    L - Turn "left" (i.e. rotate 90 degrees anticlockwise)
    R - Turn "right" (i.e. rotate 90 degrees clockwise)

As the robot moves forward, if there is not enough space in the grid, the grid should expand accordingly. So:
execute("FFFFF"); // => "******"

Each row in your grid must be separated from the next by a CRLF (\r\n). Let's look at another example:

execute("FFFFFLFFFFFLFFFFFLFFFFFL"); // => "******\r\n*    *\r\n*    *\r\n*    *\r\n*    *\r\n******"

/*
  The grid looks like this:
  ******
  *    *
  *    *
  *    *
  *    *
  ******
*/

Another example:

execute("LFFFFFRFFFRFFFRFFFFFFF"); // => "    ****\r\n    *  *\r\n    *  *\r\n********\r\n    *   \r\n    *   "

/*
  The grid looks like this:
      ****
      *  *
      *  *
  ********
      *
      *
*/

Initially the robot turns left to face upwards, then moves upwards 5 squares,
then turns right and moves 3 squares, then turns right again (to face
downwards) and move 3 squares, then finally turns right again and moves 7
squares.

Since you've realised that it is probably quite inefficient to repeat certain
commands over and over again by repeating the characters (especially the F
command - what if you want to move forwards 20 steps?), you decide to allow a
shorthand notation in the RS1 specification which allows your customers to
postfix a non-negative integer onto a command to specify how many times an
instruction is to be executed:

    Fn - Execute the F command n times (NOTE: n may be more than 1 digit long!)
    Ln - Execute L n times
    Rn - Execute R n times

So the example directly above can also be written as:
LF5RF3RF3RF7
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

# print(execute(""))
print(execute("FFLFFLFFLFFL"))
print(execute('LF5RF3RF3RF7'))
