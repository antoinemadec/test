#ifndef SERVER_H
#define SERVER_H

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <set>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <ifaddrs.h>

#define BASE_PORT 8100
#define FILENAME_MAX_SIZE 256

/**
 * Implementation of a non-blocking socket server
 *
 * Main features:
 *  - finds 1st port available starting from BASE_PORT
 *  - write port and ip info in 'server_<serverName>.txt' at start()
 *  - forbids servers with the same name
 */
class Server {
    public:
        Server(char const *name);
        void start();
        int acceptNewSocket();
        char const *serverName;

    private:
        int server_fd;
        struct sockaddr_in address;
        int addrlen = sizeof(address);
        char const *getIp(char const *interface);
        static std::set<char const *> serverNameSet;
};
#endif
