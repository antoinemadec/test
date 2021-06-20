#!/usr/bin/env python3

"""
https://www.codewars.com/kata/53005a7b26d12be55c000243/train/python

Variables
Any identifier which is not a keyword will be treated as a variable. If the
identifier is on the left hand side of an assignment operator, the result of
the right hand side will be stored in the variable. If a variable occurs as
part of an expression, the value held in the variable will be substituted when
the expression is evaluated.

Variables are implicitly declared the first time they are assigned to.

Example: Initializing a variable to a constant value and using the variable in
another expression (Each line starting with a '>' indicates a separate call to
the input method of the interpreter, other lines represent output)

>x = 7
    7
>x + 6
    13    
Referencing a non-existent variable will cause the interpreter to throw an
error. The interpreter should be able to continue accepting input even after
throwing.

Example: Referencing a non-existent variable

>y + 7
    ERROR: Invalid identifier. No variable with name 'y' was found."
Assignments
An assignment is an expression that has an identifier on left side of an =
operator, and any expression on the right. Such expressions should store the
value of the right hand side in the specified variable and return the result.

Example: Assigning a constant to a variable

x = 7
    7
In this kata, all tests will contain only a single assignment. You do not need to consider chained or nested assignments.

Operator Precedence
Operator precedence will follow the common order. There is a table in the
Language section below that explicitly states the operators and their relative
precedence.

Name conflicts
Because variables are declared implicitly, no naming conflicts are possible.
variable assignment will always overwrite any existing value.

Input
Input will conform to the expression production in the grammar below.

Output
Output for a valid expression will be the result of the expression.

Output for input consisting entirely of whitespace will be an empty string
(null in case of Java).

All other cases will throw an error.

Language
Grammar
This section specifies the grammar for the interpreter language in EBNF syntax

expression      ::= factor | expression operator expression
factor          ::= number | identifier | assignment | '(' expression ')'
assignment      ::= identifier '=' expression

operator        ::= '+' | '-' | '*' | '/' | '%'

identifier      ::= letter | '_' { identifier-char }
identifier-char ::= '_' | letter | digit

number          ::= { digit } [ '.' digit { digit } ]

letter          ::= 'a' | 'b' | ... | 'y' | 'z' | 'A' | 'B' | ... | 'Y' | 'Z'
digit           ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
Operator Precedence
The following table lists the language's operators grouped in order of precedence. Operators within each group have equal precedence.

Category    Operators
Multiplicative    *, /, %
Additive    +, -
Assignment    =
"""

import re


def tokenize(expression):
    if expression == "":
        return []

    regex = re.compile(
        r"\s*(=>|[-+*\/\%=\(\)]|[A-Za-z_][A-Za-z0-9_]*|[0-9]*\.?[0-9]+)\s*")
    tokens = regex.findall(expression)
    return [s for s in tokens if not s.isspace()]


class Interpreter:
    op_funcs = {'+': lambda a, b: a+b,
                '-': lambda a, b: a-b,
                '*': lambda a, b: a*b,
                '/': lambda a, b: a/b,
                '%': lambda a, b: a % b}

    def __init__(self):
        self.vars = {}
        self.functions = {}

    def input(self, expression):
        tokens = tokenize(expression)
        return self.solve_expression(tokens)

    def resolve_digit_or_identifier(self, e):
        if isinstance(e, (float, int)):
            return e
        elif e.isnumeric():
            try:
                return int(e)
            except ValueError:
                return float(e)
        elif e.isalpha() and e in self.vars:
            return self.vars[e]
        raise Exception('ERROR')

    def find_first_parenthesis_pair(self, e):
        cnt = 0
        for i, token in enumerate(e):
            if token == '(':
                cnt += 1
                j = i
            elif token == ')':
                cnt -= 1
                if cnt == 0:
                    return (j, i)
        return None

    def find_first_exp_op_exp(self, e):
        for i, token in enumerate(e):
            if token in ('*', '/', '%'):
                return (i-1, i+1)
        for i, token in enumerate(e):
            if token in ('+', '-'):
                return (i-1, i+1)
        raise Exception('ERROR')

    def find_highest_priority_indexes(self, e):
        idx = self.find_first_parenthesis_pair(e)
        if not idx:
            idx = self.find_first_exp_op_exp(e)
        return idx

    def cleanup_expression(self, e):
        # remove external parenthesis is any
        while e[0] == '(' and e[-1] == ')':
            del e[0]
            del e[-1]

    def solve_expression(self, exp):
        self.cleanup_expression(exp)

        # final expression
        if len(exp) == 1:
            return self.resolve_digit_or_identifier(exp[0])
        # solve exp op exp
        elif len(exp) == 3:
            op = exp[1]
            e1 = self.resolve_digit_or_identifier(exp[2])
            # assignment
            if op == "=":
                self.vars[exp[0]] = e1
                return e1
            # not assignment
            else:
                e0 = self.resolve_digit_or_identifier(exp[0])
                return self.op_funcs[op](e0, e1)
        # replace expressions in expression
        else:
            while len(exp) != 1:
                idx = self.find_highest_priority_indexes(exp)
                highest_prio_exp = exp[idx[0]:idx[1] + 1]
                del exp[idx[0]:idx[1]]
                exp[idx[0]] = self.solve_expression(highest_prio_exp)
            return exp[0]


# --------------------------------------------------------------
# tests
# --------------------------------------------------------------

def run_test(s):
    print(">" + s)
    print("  " + str(interpreter.input(s)))


interpreter = Interpreter()

# Basic arithmetic
run_test("1 + 1")
run_test("1 + 1 * 2 + 2")
run_test("(1 + 1) * 2 + 2")
run_test("2 - 1")
run_test("2 * 3")
run_test("8 / 4")
run_test("7 % 4")

# Variables
run_test("x = 1")
run_test("x")
run_test("x + 3")
# test.expect_error("input: 'y'", lambda: interpreter.input("y"))
