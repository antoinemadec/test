#include <iostream>
#include <string>


struct Employee
{
    std::string name;
    std::string job;
};

int sumTo(int n)
{
    int sum(0);
    for (int i=0; i<=n; i++)
    {
        sum += i;
    }
    return sum;
}

void printEmployeeName(const Employee &e)
{
    std::cout << "Employee name: " << e.name << "\n";
}

void minMax(int a, int b, int &smaller, int &greater)
{
    if (a<b)
    {
        smaller = a;
        greater = b;
    }
    else
    {
        smaller = b;
        greater = a;
    }
}

int getIndexOfLargestValue(const int *array, const int length)
{
    int max(array[0]), maxIndex(0);
    for (int i=1; i<length; i++)
    {
        if (max<array[i])
        {
            max = array[i];
            maxIndex = i;
        }
    }
    return maxIndex;
}

const int& getElement(const int *array, const int length)
{
    int i = getIndexOfLargestValue(array, length);
    static const int &ref = array[i];
    return ref;
}

int main()
{
    std::cout << "sumTo(100)=" << sumTo(100) << "\n";

    Employee e;
    e.name = "Antoine";
    printEmployeeName(e);

    int s,g;
    minMax(9,1,s,g);
    std::cout << s << "<" << g << "\n";

    int array[4] = {25,99, 15, -1};
    std::cout << "max index: " << getIndexOfLargestValue(array, 4) << "\n";
    std::cout << "max value: " << getElement(array, 4) << "\n";
}
