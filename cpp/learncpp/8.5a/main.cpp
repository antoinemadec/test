#include <iostream>
#include <stdio.h>
#include <cstdint>

using namespace std;

class RGBA
{
    uint8_t m_red, m_green, m_blue, m_alpha;

    public:
    RGBA(uint8_t r=0, uint8_t g=0, uint8_t b=0, uint8_t a=255):
        m_red(r), m_green(g), m_blue(b), m_alpha(a)
    {
    }

    void print()
    {
       printf("r=%0d g=%0d b=%0d a=%0d\n", m_red, m_green, m_blue, m_alpha);
    }
};

int main()
{
    RGBA teal(0, 127, 127);
    teal.print();

    return 0;
}
