#include <assert.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <stdint.h>
#include <cstring>


class XrunQueue {
    public:
        uint8_t  *array;
        uint32_t byte_size;
        void Free();
        void PushData(void *data, uint32_t byte_nb);
        void PushZeros(uint32_t byte_nb);
    private:
        void AllocMoreBytes(uint32_t byte_nb);
};

void XrunQueue::Free() {
    if (byte_size != 0) {
        free(array);
        array = (uint8_t *) malloc(0);
        byte_size = 0;
    }
}

void XrunQueue::PushData(void *data, uint32_t byte_nb) {
    uint32_t prev_byte_size = byte_size;
    AllocMoreBytes(byte_nb);
    memcpy(&array[prev_byte_size], data, byte_nb);
}

void XrunQueue::PushZeros(uint32_t byte_nb) {
    uint32_t prev_byte_size = byte_size;
    AllocMoreBytes(byte_nb);
    memset(&array[prev_byte_size], 0, byte_nb);
}

void XrunQueue::AllocMoreBytes(uint32_t byte_nb) {
    byte_size += byte_nb;
    array = (uint8_t*) realloc(array, byte_size);
    assert(array != NULL);
}


int main(int argc, char const *argv[]) {
    XrunQueue *q;
    uint32_t data[8];
    uint32_t *big_data;
    q = new XrunQueue();
    for (int l=0; l<10; l++) {
        // new run
        q->Free();
        // ... nothing happens
        // new run
        q->Free();
        big_data = (uint32_t *) malloc(1024*1024*1024);
        q->PushData(data, 4);
        q->PushData(big_data, 1024*1024*1024);
        q->PushData(data, 4);
        q->PushZeros(4);
        for (int i=0; i<4; i++) {
            printf("q3[%0d] = 0x%x\n", i, q->array[i]);
            printf("q3[%0d] = 0x%x\n", 4+1024*1024*1024+i, q->array[4+1024*1024*1024+i]);
            printf("q3[%0d] = 0x%x\n", 8+1024*1024*1024+i, q->array[8+1024*1024*1024+i]);
        }
        free(big_data);
    }
}
