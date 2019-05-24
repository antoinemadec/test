#include "server.h"

std::set<char const *> Server::serverNameSet;

Server::Server(char const *name) : serverName(name) {
    if (Server::serverNameSet.find(name) != Server::serverNameSet.end())
    {
        fprintf(stderr, "Server name (%s) already exist, use another name\n", name);
        exit(EXIT_FAILURE);
    }
    Server::serverNameSet.insert(name);
}

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
    if (listen(server_fd, 8) < 0)
    {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    // print server's ip and port
    char serverInfoFile[FILENAME_MAX_SIZE + 1];
    snprintf(serverInfoFile, FILENAME_MAX_SIZE, "server_%s.txt", serverName);
    fp = fopen(serverInfoFile, "w+");
    fprintf(fp, "ip: %s\n", getIp());
    fprintf(fp, "port: %0d\n", port);
    fclose(fp);
}

int Server::acceptNewSocket() {
    return accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen);
}

char const *Server::getIp() {
    setenv("LANG","C",1);
    FILE * fp = popen("hostname -I", "r");
    if (fp) {
        char *p=NULL; size_t n;
        while ((getline(&p, &n, fp) > 0) && p) {
            char *pos;
            if ((pos=strchr(p, '\n')) != NULL)
                *pos = '\0';
            return p;
        }
    }
    pclose(fp);
    return NULL;
}
