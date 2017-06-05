#include <iostream>

double max(double a, double b)
{
    return (a>b ? a:b);
}

void swap(int &a, int &b)
{
    double tmp;
    tmp = a;
    a = b;
    b = tmp;
}

int& getLargestElement(int *array, int length)
{
    int maxIndex(0);
    for (int i=1; i<length; i++)
        if (array[maxIndex] < array[i])
            maxIndex = i;
    return array[maxIndex];
}

int main()
{
    int a(123), b(654);
    int array[] = {2, 5, 98, 5, 69};
    std::cout << "Max: " << max(a,b) << "\n";
    swap(a,b);
    std::cout << "Swap: " << a << " " << b << "\n";
    int &largestElement = getLargestElement(array, 5);
    std::cout << "largestElement: " << largestElement << "\n";
    largestElement = 29;
    std::cout << "array[2] (modified largestElement): " << array[2] << "\n";
    return 0;
}
