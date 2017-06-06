#include <iostream>

class Point3d
{
    double m_x, m_y, m_z;
public:
    void setValues(double x, double y, double z)
    {
        m_x = x;
        m_y = y;
        m_z = z;
    }

    int isEqual(const Point3d &p)
    {
        return ((m_x == p.m_x) && (m_y == p.m_y) && (m_z == p.m_z));
    }

    void print()
    {
        std::cout << '<' << m_x << ',' << m_y << ',' << m_z << ">\n";
    }
};

int main()
{
    Point3d point1;
    point1.setValues(1.0, 2.0, 3.0);

    Point3d point2;
    point2.setValues(1.0, 2.0, 3.0);

    if (point1.isEqual(point2))
        std::cout << "point1 and point2 are equal\n";
    else
        std::cout << "point1 and point2 are not equal\n";

    Point3d point3;
    point3.setValues(3.0, 4.0, 5.0);

    if (point1.isEqual(point3))
        std::cout << "point1 and point3 are equal\n";
    else
        std::cout << "point1 and point3 are not equal\n";

    return 0;
}
