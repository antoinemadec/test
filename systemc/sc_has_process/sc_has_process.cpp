// since SC_CTOR has a constructor functior declarition, it can only be placed inside class header.
//
// My recommendation:
//   1. Don't use SC_CTOR or SC_HAS_PROCESS if a module has no simulation process (member functions
//   registered to simulation kernel via SC_METHOD/SC_THREAD/SC_CTHREAD)
//   2. Use SC_CTOR if the module need no additional parameter (other than module name) to
//   instantiate
//   3. Use SC_HAS_PROCESS when additional parameters are needed during instantiation

#include <systemc>
using namespace sc_core;

//-------------------------------------------------------------
// no sim process: no need for SC_CTOR/SC_HAS_PROCESS
//-------------------------------------------------------------
SC_MODULE(MODULE_A) {
  // the base class is implicitly instantiated with module name.
  MODULE_A(sc_module_name name) { func_a(); }

  void func_a() { printf("%s, neither SC_CTOR nor SC_HAS_PROCESS\n", name()); }
};

//-------------------------------------------------------------
// 1 arg: use SC_CTOR
//-------------------------------------------------------------
SC_MODULE(MODULE_B1) {
  SC_CTOR(MODULE_B1) {
    SC_METHOD(func_b);
  }

  void func_b() { printf("%s, SC_CTOR\n", name()); }
};

//-------------------------------------------------------------
// 1 arg: SC_HAS_PROCESS is longer to write
//-------------------------------------------------------------
SC_MODULE(MODULE_B2) {
  SC_HAS_PROCESS(MODULE_B2);

  MODULE_B2(sc_module_name name) { SC_METHOD(func_b); }

  void func_b() { printf("%s, SC_HAS_PROCESS\n", name()); }
};

//-------------------------------------------------------------
// multiple args: use SC_HAS_PROCESS
//-------------------------------------------------------------
SC_MODULE(MODULE_C) {
  const int i;

  SC_HAS_PROCESS(MODULE_C);

  MODULE_C(sc_module_name name, int i) : i(i) { SC_METHOD(func_c); }

  void func_c() { printf("%s, SC_HAS_PROCESS, i=%d\n", name(), i); }
};

//-------------------------------------------------------------
// SC_CTOR inside header, constructor defined outside header
//-------------------------------------------------------------
SC_MODULE(MODULE_D1) {
  SC_CTOR(MODULE_D1);
  void func_d() {
    printf("%s, SC_CTOR inside header, constructor defined outside header\n", name());
  }
};

MODULE_D1::MODULE_D1(sc_module_name name) : sc_module(name) { SC_METHOD(func_d); }

//-------------------------------------------------------------
// SC_HAS_PROCESS inside header, constructor defined outside header
//-------------------------------------------------------------
SC_MODULE(MODULE_D2) {
  SC_HAS_PROCESS(MODULE_D2);
  MODULE_D2(sc_module_name);
  void func_d() {
    printf("%s, SC_HAS_PROCESS inside header, constructor defined outside header\n", name());
  }
};

MODULE_D2::MODULE_D2(sc_module_name name) : sc_module(name) { SC_METHOD(func_d); }

//-------------------------------------------------------------
// SC_CURRENT_USER_MODULE and constructor defined outside header
//-------------------------------------------------------------
SC_MODULE(MODULE_E) {
  MODULE_E(sc_module_name name);
  void func_e() { printf("%s, SC_HAS_PROCESS outside header, CANNOT use SC_CTOR\n", name()); }
};

MODULE_E::MODULE_E(sc_module_name name) {
  // NOT OK to use SC_CTOR
  SC_HAS_PROCESS(MODULE_E);
  SC_METHOD(func_e);
}

//-------------------------------------------------------------
// main
//-------------------------------------------------------------
int sc_main(int, char *[]) {
  MODULE_A module_a("module_a");
  MODULE_B1 module_b1("module_b1");
  MODULE_B2 module_b2("module_b2");
  MODULE_C module_c("module_c", 29);
  MODULE_D1 module_d1("module_d1");
  MODULE_D2 module_d2("module_d2");
  MODULE_E module_e("module_e");
  sc_start();
  return 0;
}
