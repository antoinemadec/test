#include <iostream>

void swap(int &a, int &b)
{
    int tmp;
    tmp = a;
    a = b;
    b = tmp;
}

int main()
{
    int a(2), b(3);
    std::cout << a << b << "\n";
    swap(a,b);
    std::cout << a << b << "\n";
}
