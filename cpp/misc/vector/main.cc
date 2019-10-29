#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <stdint.h>
#include <cstring>

int main(int argc, char const *argv[]) {
    // vect
    std::vector<uint32_t> int_vect;
    int_vect.push_back(0xdeadbeef);
    int_vect.push_back(0xcafedeca);
    for (int v : int_vect) {
        printf("val = 0x%x\n", v);
    }
    // cast to uint32_t *p
    uint32_t *p = &int_vect[0];
    uint32_t *p2;
    p2 = (uint32_t *) malloc(8);
    printf("size = %0d\n", int_vect.size());
    for (int i=0; i<int_vect.size(); i++)
        printf("p[%0d] = 0x%x\n", i, p[i]);
    memcpy(p2, p, 8);
    printf("p2[0] = 0x%x\n", p2[0]);
}
