#include <iostream>
#include <string>

class Employee
{
    public:
        std::string m_name;
        int m_id;
        double m_wage;

        void print()
        {
            std::cout << "Name: " << m_name << " Id: " << m_id << " Wage: $" << m_wage << '\n';
        }
};

int main()
{
    Employee alex { "Alex", 1, 25.00 };
    Employee joe {"Joe", 2, 22.50 };

    alex.print();
    joe.print();

    return 0;
}
