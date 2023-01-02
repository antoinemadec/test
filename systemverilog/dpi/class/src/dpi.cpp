#include <stdio.h>
#include <svdpi.h>


class MyClass
{
private:
  int idx;

public:
  MyClass() {
    idx = 0;
  }

  int get_next_val() {
    idx++;
    return idx * idx;
  }

  int get_idx() {
    return idx;
  }
};


// for C++, use extern "C" on all functions: imported and exported
extern "C" void sv_write(int add, int wdata);
extern "C" int c_init();
extern "C" int c_fill_next_value();

MyClass *mc;

int c_init() {
  mc = new MyClass();
  return 0;
}

int c_fill_next_value() {
  int idx;
  int next_val;
  idx = mc->get_idx();
  next_val = mc->get_next_val();
  sv_write(idx, next_val);
  return 0;
}
