#include <stdio.h>
#include <stdint.h>
#include <math.h>

int main()
{
    int i,j;
    printf("enter 2 numbers: ");
    scanf("%d %d", &i, &j);
    if (i>j)
    {
        int k;
        k = j;
        j = i;
        i = k;
    }
    printf("%0d <= %0d\n", i, j);
    return 0;
}
