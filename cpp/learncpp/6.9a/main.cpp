#include <iostream>

int main()
{
    int nameNumber;
    using namespace std;
    cout << "How many names ? ";
    cin >> nameNumber;

    string *names = new std::string[nameNumber];
    int i;
    for (i=0; i<nameNumber; i++)
    {
        cin >> names[i];
    }
    for (i=0; i<nameNumber; i++)
    {
        cout << names[i] << '\n';
    }
    delete[] names;
    names = NULL;
}
