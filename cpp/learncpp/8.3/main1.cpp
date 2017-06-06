#include <iostream>

class DateClass
{
    int m_month;
    int m_day;
    int m_year;

    public:
    void setDate(int m, int d, int y)
    {
        m_month = m;
        m_day   = d;
        m_year  = y;
    }

    void print()
    {
        std::cout << m_month << '/' << m_day << '/' << m_year << '\n';
    }
};

int main()
{
    DateClass d;

    d.setDate(10,23,2017);
    d.print();
}
