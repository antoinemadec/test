#include <stdio.h>
#include <svdpi.h>

extern void sv_write(int add, int wdata);
extern void sv_read(int add, int *rdata);

int c_run() {
  int rdata0;
  int rdata1;

  printf("\nC: call writes\n");
  sv_write(0x0,    0xdeadbeef);
  sv_write(0x1000, 0xcafedeca);

  printf("\nC: call reads\n");
  sv_read(0x0,    &rdata0);
  sv_read(0x1000, &rdata1);
  printf("C: rdata0=0x%x\n", rdata0);
  printf("C: rdata1=0x%x\n\n", rdata1);

  return 0;
}
