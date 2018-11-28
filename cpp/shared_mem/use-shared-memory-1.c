// Note: Link with -lrt

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>        /* For mode constants */
#include <fcntl.h>           /* For O_* constants */
#include <unistd.h>
#include <string.h>

#include <assert.h>

int main() {

    int oflags=O_RDWR | O_CREAT;

    off_t       length  = 2 * 1024;
    const char *name    = "/antoine.test";
    int         fd      = shm_open(name, oflags, 0644 );

    ftruncate(fd, length);

    fprintf(stderr,"Shared Mem Descriptor: fd=%d\n", fd);

    assert (fd>0);

    u_char *ptr = (u_char *) mmap(NULL, length, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

    fprintf(stderr, "Shared Memory Address: %p [0..%lu]\n", ptr, length-1);
    fprintf(stderr, "Shared Memory Path: /dev/shm/%s\n", name );

    assert (ptr);

    const char *msg = "hello world!!\n";

    strcpy((char*)ptr,msg);


    close(fd);
    exit(0);
}
