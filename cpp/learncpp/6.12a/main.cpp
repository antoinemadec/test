#include <iostream>

int main()
{
    using namespace std;

    const string names[] = {"Alex", "Betty", "Caroline", "Dave", "Emily", "Fred", "Greg", "Holly"};
    std::string name;

    cout << "Enter a name: ";
    cin >> name;
    for (auto &n: names)
    {
        if (n == name)
        {
            cout << n << " is in the list.\n";
            return 0;
        }
    }
    cout << name << " is not in the list.\n";
    return 1;
}
