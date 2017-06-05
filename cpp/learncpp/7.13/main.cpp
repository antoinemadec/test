#include <stdio.h>

int main(int argc, char *argv[])
{
    for (int i=0; i<argc; i++)
        printf("arg[%0d] = %s\n", i, argv[i]);
}
