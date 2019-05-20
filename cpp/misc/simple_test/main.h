#include <stdint.h>

class Rectangle {
  public:
    Rectangle(uint32_t, uint32_t);
    virtual ~Rectangle();
    uint32_t a, b;
    uint32_t GetArea();
};

class Square : public Rectangle {
  public:
    Square(uint32_t);
};
