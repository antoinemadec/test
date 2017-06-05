#include <stdio.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
    char *str;
    int i;
    float f;
    f = 9.87654321f;
    for (i=0; i<argc; i++)
    {
        str = argv[i];
    }
    printf("%s f=%f\n", str, f);
    return 0;
}
