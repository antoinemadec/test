#include <stdio.h>
#include <stdint.h>

uint32_t invert_bits(int i)
{
    uint32_t j = 0;
    while (i!=0)
    {
        j <<= 1;
        j +=  i&0x1;
        i >>= 1;

    }
    return j;
}

int main()
{
    uint32_t i;
    i = 237;
    printf("i=%0d\n", i);
    printf("j=%0d\n", invert_bits(i));
}
