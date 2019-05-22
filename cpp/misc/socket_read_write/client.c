// https://www.geeksforgeeks.org/socket-programming-cc/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#define DEFAULT_PORT 8100

void usage(char * const argv[]) {
    fprintf(stderr, "Usage: %s\n"
            "\t-a <ip>         : server ip adress (default is localhost)\n"
            "\t-p <ip>         : server port number (default is 8100)\n"
            "\t-r <address>    : read address\n"
            "\t-w <address>    : write address\n"
            "\t-d <data>       : write data\n"
            "\nExample (write & read @ 0x0):\n"
            "\t%s -w 0x00000000 -d 0xdeadbeef\n"
            "\t%s -r 0x00000000\n",
            argv[0], argv[0], argv[0]);
    exit(EXIT_FAILURE);
}


int main(int argc, char * const argv[])
{
    int sock = 0;
    struct sockaddr_in serv_addr;
    char const *server_address = "127.0.0.1";
    int server_port = DEFAULT_PORT;
    uint32_t send_buf[3];
    // send_buf[0]: rwB
    // send_buf[1]: address
    // send_buf[2]: write data (if rwB=0)
    uint32_t read_buf[1];
    // read_buf[0]: read data
    int opt;

    // arg parsing
    if (argc < 2)
        usage(argv);
    while((opt = getopt(argc, argv, "a:p:r:w:d:")) != -1)
    {
        switch(opt)
        {
            case 'a':
                server_address = optarg;
                break;
            case 'p':
                server_port = (int)strtol(optarg, NULL, 0);
                break;
            case 'r':
                send_buf[0] = 1;
                send_buf[1] = (int)strtol(optarg, NULL, 0);
                break;
            case 'w':
                send_buf[0] = 0;
                send_buf[1] = (int)strtol(optarg, NULL, 0);
                break;
            case 'd':
                send_buf[2] = (int)strtol(optarg, NULL, 0);
                break;
            default:
                usage(argv);
                break;
        }
    }

    // connect to server
    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("\n Socket creation error \n");
        return -1;
    }
    memset(&serv_addr, '0', sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(server_port);
    if(inet_pton(AF_INET, server_address, &serv_addr.sin_addr)<=0)
    {
        printf("\nInvalid address/ Address not supported \n");
        return -1;
    }
    if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
    {
        printf("\nConnection Failed \n");
        return -1;
    }

    // send and receive data
    send(sock, send_buf, sizeof(send_buf), 0);
    if (send_buf[0] == 1) {
        // read command
        read( sock , read_buf, sizeof(read_buf));
        printf("0x%x\n", read_buf[0]);
    }
    return 0;
}
