#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void call(void (*cb)(void)) {
  if (cb != NULL) {
    printf("call:\n");
    cb();
  }
}


void my_cb() {
  printf("this is my cb\n");
}

int main() {
  call(my_cb);
  call(NULL);
  return 0;
}
