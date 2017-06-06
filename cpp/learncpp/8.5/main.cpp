#include <iostream>


class Ball
{
    std::string m_color;
    double m_radius;

    public:
    Ball()
    {
        m_color = "Black";
        m_radius = 10.0;
    }
    Ball(std::string color)
    {
        m_color = color;
        m_radius = 10.0;
    }
    Ball(double r)
    {
        m_color = "Black";
        m_radius = r;
    }
    Ball(std::string color, double r)
    {
        m_color = color;
        m_radius = r;
    }

    void print()
    {
        std::cout << "color: " << m_color << ", radius: " << m_radius << "\n";
    }
};

int main()
{
    Ball def;
    def.print();

    Ball blue("blue");
    blue.print();

    Ball twenty(20.0);
    twenty.print();

    Ball blueTwenty("blue", 20.0);
    blueTwenty.print();
    return 0;
}
