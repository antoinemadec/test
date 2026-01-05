#include <systemc>
using namespace sc_core;

//-------------------------------------------------------------
// normal
//-------------------------------------------------------------
SC_MODULE(MODULE_A) {
  SC_CTOR(MODULE_A) {
    SC_METHOD(func_a);
  }

  void func_a() { printf("%s\n", name()); }
};

//-------------------------------------------------------------
// define function outside
//-------------------------------------------------------------
SC_MODULE(MODULE_B) {
  SC_CTOR(MODULE_B) {
    SC_METHOD(func_b);
  }

  void func_b();
};

void MODULE_B::func_b() { printf("%s\n", name()); }

//-------------------------------------------------------------
// constructor taking more arguments
//-------------------------------------------------------------
SC_MODULE(MODULE_C) {
  const int i;

  SC_CTOR(MODULE_C);

  MODULE_C(sc_module_name name, int i) : sc_module(name), i(i) { SC_METHOD(func_c); }

  void func_c() { printf("%s i=%0d\n", name(), i); }
};

int sc_main(int, char *[]) {
  MODULE_A module_a("module_a");
  MODULE_B module_b("module_b");
  MODULE_C module_c("module_c", 42);
  sc_start();
  return 0;
}
