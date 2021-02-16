#include "svdpi.h"
#include "stdio.h"
#include "assert.h"


extern void test_access_dpi_sv();


int test_run_dpi_c() {
  char path_str [1024];
  int n;

  for (int i = 0; i < 8; i++) {
    // change scope
    n = sprintf(path_str, "test.ram%0d.ram_dpi", i);
    assert((n>0) && (n<1024));
    svSetScope(svGetScopeFromName(path_str));
    // run DPI
    test_access_dpi_sv(0xdeadbee0 + i);
  }
  return 0;
}
