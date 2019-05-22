// https://www.geeksforgeeks.org/socket-programming-cc/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include "server.h"

int main(int argc, char const *argv[])
{
    uint32_t read_buf[3];
    // read_buf[0]: rwB
    // read_buf[1]: address
    // read_buf[2]: write data (if rwB=0)
    uint32_t send_buf[1];
    // send_buf[0]: read data
    uint32_t mem[1024>>2];

    Server *server = new Server("memAccess");
    server->start();

    // accept connection
    int new_socket;
    while (1) {
        if ((new_socket = server->acceptNewSocket())<0)
        {
            sleep(1);
            continue;
        }
        read(new_socket , read_buf, sizeof(read_buf));
        if (read_buf[0] == 0) {
            // write command
            mem[read_buf[1]>>2] = read_buf[2];
            printf("0x%x -> [0x%x]\n", read_buf[2], read_buf[1]);
        } else {
            // read command
            send_buf[0] = mem[read_buf[1]>>2];
            send(new_socket, send_buf, sizeof(send_buf) , 0);
            printf("0x%x <- [0x%x]\n", send_buf[0], read_buf[1]);
        }
    }
    return 0;
}
