#include "svdpi.h"
#include "stdio.h"
#include "assert.h"


extern void test_access();


int test_run_C() {
  char path_str [1024];
  int n;

  for (int i = 0; i < 8; i++) {
    // change scope
    n = sprintf(path_str, "test.ram%0d", i);
    assert((n>0) && (n<1024));
    svSetScope(svGetScopeFromName(path_str));
    // run DPI
    test_access(0xdeadbee0 + i);
  }
  return 0;
}
