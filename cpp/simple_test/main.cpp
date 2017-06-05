#include <stdio.h>
#include <stdint.h>

#include "main.h"


Rectangle::Rectangle(uint32_t a, uint32_t b) : a(a), b(b) {};
Rectangle::~Rectangle() {};
Square::Square(uint32_t a) : Rectangle(a,a) {};

uint32_t Rectangle::GetArea() {
  return (a * b);
}

Rectangle *r;
Square *s;

int main()
{
  printf("Start\n");
  r = new Rectangle(4,10);
  s = new Square(5);
  printf("R Area=%d\n", r->GetArea());
  printf("S Area=%d\n", s->GetArea());
}
