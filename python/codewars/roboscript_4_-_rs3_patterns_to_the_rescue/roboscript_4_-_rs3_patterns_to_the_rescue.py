#!/usr/bin/env python3

'''
Like function/method definitions in other languages, merely defining a pattern
(or patterns) in RS3 should cause no side effects, so:
execute('p0(F2LF2R)2q'); // => '*'
execute('p312(F2LF2R)2q'); // => '*'

To invoke a pattern (i.e. make the MyRobot move according to the movement
sequences defined inside the pattern), a capital P followed by the pattern
identifier (n) is used:
execute('p0(F2LF2R)2qP0'); // => "    *\r\n    *\r\n  ***\r\n  *  \r\n***  "
execute('p312(F2LF2R)2qP312'); // => "    *\r\n    *\r\n  ***\r\n  *  \r\n***  "

Additional Rules for parsing RS3

It doesn't matter whether the invocation of the pattern or the pattern
definition comes first - pattern definitions should always be parsed first, so:

execute('P0p0(F2LF2R)2q'); // => "    *\r\n    *\r\n  ***\r\n  *  \r\n***  "
execute('P312p312(F2LF2R)2q'); // => "    *\r\n    *\r\n  ***\r\n  *  \r\n***  "

Of course, RoboScript code can occur anywhere before and/or after a pattern
definition/invocation, so:

execute('F3P0Lp0(F2LF2R)2qF2'); // => "       *\r\n       *\r\n       *\r\n       *\r\n     ***\r\n     *  \r\n******  "

Much like a function/definition can be invoked multiple times in other
languages, a pattern should also be able to be invoked multiple times in RS3.
So:

execute('(P0)2p0F2LF2RqP0'); // => "      *\r\n      *\r\n    ***\r\n    *  \r\n  ***  \r\n  *    \r\n***    "

If a pattern is invoked which does not exist, your interpreter should throw.
This could be anything and will not be tested, but ideally it should provide a
useful message which describes the error in detail. In PHP this must be an
instance of ParseError.

execute('p0(F2LF2R)2qP1'); // throws ParseError
execute('P0p312(F2LF2R)2q'); // throws ParseError
execute('P312'); // throws ParseError

Much like any good programming language will allow you to define an unlimited
number of functions/methods, your RS3 interpreter should also allow the user to
define a virtually unlimited number of patterns. A pattern definition should be
able to invoke other patterns if required. If the same pattern (i.e. both
containing the same identifier (n)) is defined more than once, your interpreter
should throw (again, anything). In PHP this error must again be an instance of
ParseError.

execute('P1P2p1F2Lqp2F2RqP2P1'); // => "  ***\r\n  * *\r\n*** *"
execute('p1F2Lqp2F2Rqp3P1(P2)2P1q(P3)3'); // => "  *** *** ***\r\n  * * * * * *\r\n*** *** *** *"
execute('p1F2Lqp1(F3LF4R)5qp2F2Rqp3P1(P2)2P1q(P3)3'); // throws ParseError

Furthermore, your interpreter should be able to detect (potentially) infinite
recursion, including mutual recursion. Instead of just getting stuck in an
infinite loop and timing out, your interpreter should throw (yes, anything
again) when the "stack" (or just the total number of pattern invocations)
exceeds a particular very high (but sensible) threshold. In PHP, the thrown
error once again must be an instance of ParseError.

execute('p1F2RP1F2LqP1'); // throws ParseError
execute('p1F2LP2qp2F2RP1qP1'); // throws ParseError

For the sake of simplicity, you may assume that all programs passed into your
interpreter contains valid syntax and that pattern definitions will never be
empty. Furthermore, nesting pattern definitions is not allowed either (it is
considered a syntax error) so your interpreter will not need to account for
these.

TL;DR:
    - read pattern definition first: p<number>q
    - called pattern like so, parenthesis accepted: (P<number>)2
    - pattern calls can be be nested
    - throws error if:
        + pattern definition is nested
        + infinite calls
'''


# import numpy as np
import re

class M():
    MAX_COUNT = 1024

    def __init__(self):
        self.m = np.ones((1,1),dtype=int)
        self.dir = 0
        self.coord = [0,0]
        self.patterns = {}

    def execute(self,cmd):
        cmd = self.parse_patterns(cmd)
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

    def parse_patterns(self, cmd):
        # definition
        while True:
            m = re.match('(?P<before>.*)p(?P<n>\d+)(?P<def>[^q]*)q(?P<after>.*)',cmd)
            if m:
                if re.match('.*[pq].*',m.group('def')):
                    raise SyntaxError
                if m.group('n') in self.patterns:
                    raise SyntaxError
                self.patterns[m.group('n')] = m.group('def')
                cmd = m.group('before') + m.group('after')
            else:
                break
        # replace calls
        counts = {}
        while True:
            m = re.match('(?P<before>.*)P(?P<n>\d+)(?P<after>.*)',cmd)
            if m:
                n = m.group('n')
                counts[n] = counts.get(n,0) + 1
                if counts[n] >= self.MAX_COUNT:
                    raise SyntaxError
                try:
                    p = self.patterns[n]
                except:
                    raise SyntaxError
                cmd = m.group('before') + p + m.group('after')
            else:
                break
        return cmd

    def update_coord(self):
        self.coord[-1+(self.dir&1)] += (1,-1)[self.dir == 1 or self.dir == 2]

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

print(execute('P1P2p1F2Lqp2F2RqP2P1'))
print(execute('p1F2Lqp2F2Rqp3P1(P2)2P1q(P3)3'))

# must throw errors
# execute('p0(F2LF2R)2qP1')
# execute('P0p312(F2LF2R)2q')
# execute('P312')
# execute('p1F2Lqp1(F3LF4R)5qp2F2Rqp3P1(P2)2P1q(P3)3')
# execute('p1F2RP1F2LqP1')
# execute('p1F2LP2qp2F2RP1qP1')
