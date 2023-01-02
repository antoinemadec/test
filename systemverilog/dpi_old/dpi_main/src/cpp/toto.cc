#include <stdint.h>
#include <stdio.h>
#include <unistd.h>
#include "stdlib.h"
#include "svdpi.h"
#include <cstring>
#include <string.h>

extern "C" int main(int argc, char** argv);

int main(int argc, char** argv) {
    for (int i=0; i<argc; i++) {
        printf("arg[%0d] = (%s)\n", i, argv[i]);
    }
}
