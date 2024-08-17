#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>
#define DEFAULT_PORT 8100

#include "svdpi.h"

extern "C" int dpi_cpu_client_start(int idx, char const *server_address, int server_port);
extern "C" int dpi_cpu_client_send_data(const svBitVecVal *data);

int new_socket = 0;

int dpi_cpu_client_start(int idx, char const *server_address, int server_port) {
  struct sockaddr_in serv_addr;
  // connect to server
  if ((new_socket = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
    // printf("\n Socket creation error \n");
    return 0;
  }
  memset(&serv_addr, '0', sizeof(serv_addr));
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_port = htons(server_port);
  if (inet_pton(AF_INET, server_address, &serv_addr.sin_addr) <= 0) {
    // printf("\nInvalid address/ Address not supported \n");
    return 0;
  }
  if (connect(new_socket, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) <
      0) {
    // printf("\nConnection Failed \n");
    return 0;
  }

  printf("Client: [client_cpu_%0d] has started at %s:%0d\n", idx, server_address, server_port);

  return 1;
}

int dpi_cpu_client_send_data(const svBitVecVal *data) {
  int r;
  uint32_t send_buf[2];
  send_buf[0] = data[0];
  send_buf[1] = data[1];
  r = send(new_socket, send_buf, sizeof(send_buf), 0);
  if (r <= 0) { // send failed
    return 0;
  }
  return 1;
}
