#include <iostream>

using namespace std;

typedef int (*arithmeticFcn)(int,int);
int add(int a, int b)
{
    return a+b;
}
int subtract(int a, int b)
{
    return a-b;
}
int multiply(int a, int b)
{
    return a*b;
}
int divide(int a, int b)
{
    return a/b;
}

struct arithmeticStruct
{
    char op;
    arithmeticFcn fcn;
};

static arithmeticStruct arithmeticArray[] = {
    {'+', add},
    {'-', subtract},
    {'*', multiply},
    {'/', divide}
};


int getInteger()
{
    int i;
    cout << "Enter integer: ";
    cin >> i;
    return i;
}

char getOperation()
{
    char op;
    do
    {
        cout << "Enter operation: ";
        cin >> op;
    } while (op!='+' && op!='-' && op!='*' && op!='/');
    return op;
}

arithmeticFcn getArithmeticFunction(char op)
{
    for (auto &aa: arithmeticArray)
    {
        if (aa.op == op)
            return aa.fcn;
    }
    return add;
}

int main()
{
    int i0, i1;
    char op;
    arithmeticFcn fcn;
    i0 = getInteger();
    op = getOperation();
    i1 = getInteger();
    fcn = getArithmeticFunction(op);
    cout << "Result: " << fcn(i0,i1) << "\n";   // implicit dereference
    return 0;
}
