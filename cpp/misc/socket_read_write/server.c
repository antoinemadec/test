// https://www.geeksforgeeks.org/socket-programming-cc/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#define BASE_PORT 8100

char *getIp(char *interface) {
    struct ifaddrs *ifap, *ifa;
    struct sockaddr_in *sa;
    char *addr;
    getifaddrs (&ifap);
    for (ifa = ifap; ifa; ifa = ifa->ifa_next) {
        if ((strcmp(interface, ifa->ifa_name) == 0) && (ifa->ifa_addr->sa_family==AF_INET)) {
            sa = (struct sockaddr_in *) ifa->ifa_addr;
            addr = inet_ntoa(sa->sin_addr);
            return addr;
        }
    }
    freeifaddrs(ifap);
    return "127.0.0.1";
}


int main(int argc, char const *argv[])
{
    int server_fd, new_socket, valread;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);
    int i = 0;
    int port;
    FILE *fp;
    uint32_t mem[1024>>2];
    uint32_t read_buf[3];
    // read_buf[0]: rwB
    // read_buf[1]: address
    // read_buf[2]: write data (if rwB=0)
    uint32_t send_buf[1];
    // send_buf[0]: read data

    // create server
    if ((server_fd = socket(AF_INET, SOCK_NONBLOCK | SOCK_STREAM, 0)) == 0)
    {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    while (1) {
        port = BASE_PORT + i;
        address.sin_port = htons(port);
        if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) >= 0)
            break;
        i++;
    }
    if (listen(server_fd, 3) < 0)
    {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    // print server's ip and port
    fp = fopen("server.txt", "w+");
    fprintf(fp, "ip: %s\n", getIp("eth0"));
    fprintf(fp, "port: %0d\n", port);
    fclose(fp);

    // accept connection
    while (1) {
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address,
                        (socklen_t*)&addrlen))<0)
        {
            sleep(1);
            continue;
        }
        valread = read(new_socket , read_buf, sizeof(read_buf));
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
