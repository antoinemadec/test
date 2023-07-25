#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include "stdlib.h"
#include "svdpi.h"
#include "server.h"


extern "C" int uart_start_server(int idx);
extern "C" int uart_get_char(int idx, svBitVecVal* chars);


Server *server[2];
int new_socket[2];


int uart_start_server(int idx)
{
  char str[80];
  sprintf(str, "uart_%0d", idx);
  server[idx] = new Server(str);
  server[idx]->start();
  new_socket[idx] = -1;
  return 0;
}


int uart_get_char(int idx, svBitVecVal* chars) {
  uint8_t read_buf[1];
  int r;

  if (new_socket[idx] < 0) {
    new_socket[idx] = server[idx]->acceptNewSocket();
    if (new_socket[idx] < 0) {
      return 0;
    }
    fcntl(new_socket[idx], F_SETFL, O_NONBLOCK); // make read() non blocking
  }

  r = read(new_socket[idx], read_buf, sizeof(read_buf));
  if (r <= 0) {
    // -1: nothing to send
    // 0: client disconnected
    if (r == 0) {
      new_socket[idx] = -1;
    }
    return 0;
  }

  svPutPartselBit(chars, read_buf[0], 8*0, 8);
  return 1;
}
