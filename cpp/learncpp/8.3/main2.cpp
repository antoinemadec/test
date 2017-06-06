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

    void copyFrom(const DateClass &d)
    {
        m_month = d.m_month;
        m_day   = d.m_day;
        m_year  = d.m_year;
    }
};

int main()
{
    DateClass d0, d1;

    d0.setDate(10,23,2017);
    d0.print();

    d1.copyFrom(d0);
    d1.print();
}
