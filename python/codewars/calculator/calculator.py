#!/usr/bin/env python3


class ComputeParenthesis:
    def __init__(self, l):
        self.l = l

    def my_index(self, val_list=[]):
        idx = -1
        for i, val in enumerate(self.l):
            if val in val_list:
                idx = i
                break
        return idx

    def str_to_number(self, idx):
        var = self.l[idx]
        if type(var) == str:
            try:
                return int(var)
            except ValueError:
                return float(var)
        else:
            return var

    def compute_at(self, idx):
        left = self.str_to_number(idx-1)
        op = self.l[idx]
        right = self.str_to_number(idx+1)
        if op == '-':
            r = left - right
        elif op == '+':
            r = left + right
        elif op == '/':
            r = left / right
        elif op == '*':
            r = left * right
        if idx >= 2:
            self.l = self.l[0:idx-1] + [r] + self.l[idx+2:]
        else:
            self.l = [r] + self.l[idx+2:]

    def compute_signs(self, sign_list=[]):
        idx = self.my_index(sign_list)
        while idx != -1:
            self.compute_at(idx)
            idx = self.my_index(sign_list)

    def compute(self):
        self.compute_signs(['/', '*'])
        self.compute_signs(['-', '+'])
        return float(self.l[0])


class Calculator(object):
    def compute(self):
        while True:
            # find parenthesis
            start_idx = -1
            for i, e in enumerate(self.l):
                if e == '(':
                    start_idx = i
                elif e == ')':
                    end_idx = i
                    self.l.pop(end_idx)
                    self.l.pop(start_idx)
                    end_idx -= 2
                    break
            # compute, replace
            if start_idx == -1:
                val = ComputeParenthesis(self.l).compute()
                self.l = [val]
                break
            else:
                val = ComputeParenthesis(self.l[start_idx:end_idx+1]).compute()
                for _ in range(end_idx-start_idx+1):
                    self.l.pop(start_idx)
                self.l.insert(start_idx, val)

    def evaluate(self, string):
        self.l = string.split(' ')
        self.compute()
        return self.l[0]


# print(Calculator().evaluate("2 / 2 + 3 * 4 - 6"))  # 7
# print(Calculator().evaluate("( ( 20 / 0.1 ) / ( ( 2 + 3 ) * 4 - 6 ) )"))  # 14
print(Calculator().evaluate("1.1 + 2.2 + 3.3")) # 6.6
print(Calculator().evaluate("1.1 * 2.2 * 3.3")) # 7.986
