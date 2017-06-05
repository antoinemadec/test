#include <stdio.h>
#include <stdint.h>
#include <math.h>

int main(int argc, char *argv[])
{
    char *str;
    int i, j, k;
    for (i=0; i<argc; i++)
    {
        str = argv[i];
    }
    j = 16^2;       // xor
    k = pow(16,2);  // power
    printf("%s %0d %0d\n", str, j, k);
    return 0;
}
