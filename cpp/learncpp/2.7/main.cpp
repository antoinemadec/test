#include <stdio.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
    char *str, c;
    int i;
    c='a';
    for (i=0; i<argc; i++)
    {
        str = argv[i];
    }
    printf("%s %c\n", str, c);
    return 0;
}
