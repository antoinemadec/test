#include <stdio.h>
#include <svdpi.h>

extern "C" int c_add(int a, int b);

int c_add(int a, int b) {
  int s;
  s = a + b;
  printf("C: %0d+%0d=%0d\n", a, b, s);
  return s;
}
