#include <stdio.h>
#include <stdint.h>
#include "foo.h"
#include "goo.h"

int main()
{
    printf("foo=%0d ; goo=%0d\n", Foo::doSomething(2,3), Goo::doSomething(2,3));
    return 0;
}
