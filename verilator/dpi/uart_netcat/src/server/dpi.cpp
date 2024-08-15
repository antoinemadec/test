#include <stdio.h>
#include <unistd.h>
#include "stdlib.h"
#include "svdpi.h"
#include "server.h"


extern "C" int dpi_uart_start_server(int idx);
extern "C" int dpi_uart_get_char(int idx, svBitVecVal* chars);
extern "C" void dpi_uart_send_char(int idx, const svBitVecVal* chars);


Server *server[2];
int new_socket[2];


int dpi_uart_start_server(int idx)
{
  char *str = new char[80];
  sprintf(str, "uart_%0d", idx);
  server[idx] = new Server(str);
  server[idx]->start();
  new_socket[idx] = -1;
  return 0;
}


int dpi_uart_get_char(int idx, svBitVecVal* chars) {
  uint8_t read_buf[1];
  int r;

  if (new_socket[idx] < 0) {
    new_socket[idx] = server[idx]->acceptNewSocket();
    if (new_socket[idx] < 0) {
      return 0;
    }
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


void dpi_uart_send_char(int idx, const svBitVecVal* chars) {
  uint8_t send_buf[1];
  svBitVecVal b = 0;
  svGetPartselBit(&b, chars, 0*8, 8);
  send_buf[0] = b;
  send(new_socket[idx], send_buf, sizeof(send_buf) , 0);
}
