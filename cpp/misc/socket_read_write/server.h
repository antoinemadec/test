#ifndef SERVER_H
#define SERVER_H

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <ifaddrs.h>

#define BASE_PORT 8100

class Server {
    public:
        /* Server(char *name); */
        Server();
        void start();
        int acceptNewSocket();

    private:
        char *serverName;
        int server_fd;
        struct sockaddr_in address;
        int addrlen = sizeof(address);
        char *getIp(char *interface);
};
#endif
