#include <stdio.h>
#include "add.h"

int main(int argc, char *argv[])
{
    int a, b, i;
    char *str;
    for (i=0; i<argc; i++)
    {
        str = argv[i];
    }
    a = add(3,4);
    b = add(52,33);
    printf("%s a=%0d, b=%0d\n", str, a, b);
    a = add(9,1);
    b = add(5,3);
    printf("%s a=%0d, b=%0d\n", str, a, b);
    return 0;
}
