#include <stdio.h>
#include <unistd.h>
#include "stdlib.h"
#include "svdpi.h"


extern "C" void dpi_cpu_client_send_data(const svBitVecVal* data);

int new_socket;


void dpi_cpu_client_send_data(int idx, const svBitVecVal* data) {
  uint32_t send_buf[2];
  send_buf[0] = data[0];
  send_buf[1] = data[1];
  send(new_socket[idx], send_buf, sizeof(send_buf) , 0);
}
