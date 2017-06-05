#include <iostream>

using namespace std;

typedef int (*arithmeticFcn)(int,int);

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

arithmeticFcn getArithmeticFunction(char op)
{
    switch (op)
    {
        default: // default will be to add
        case '+': return add;
        case '-': return subtract;
        case '*': return multiply;
        case '/': return divide;
    }
}

int main()
{
    int i0, i1, r;
    char op;
    i0 = getInteger();
    op = getOperation();
    i1 = getInteger();
    r = (*getArithmeticFunction(op))(i0,i1);
    cout << "Result: " << r << "\n";
    return 0;
}
