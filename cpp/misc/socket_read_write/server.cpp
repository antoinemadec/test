#include "server.h"

/* Server::Server(*name) : serverName(name) {} */
Server::Server() {}

void Server::start() {
    int i = 0;
    int port;
    FILE *fp;

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
        if (bind(server_fd, (struct sockaddr *)&address, addrlen) >= 0)
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
}

int Server::acceptNewSocket() {
    return accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen);
}

char *Server::getIp(char *interface) {
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

