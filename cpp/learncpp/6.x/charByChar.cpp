#include <iostream>

void printCharByChar(const char *str)
{
    while(*str != 0)
    {
        std::cout << *str << "\n";
        str++;
    }
}

int main()
{
    printCharByChar("Hello World!");
    return 0;
}
