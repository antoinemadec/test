#include <stdio.h>
#include <unistd.h>
#include "stdlib.h"
#include "svdpi.h"
#include "server.h"


extern "C" int startServer();
extern "C" int acceptNewSocket();
extern "C" void write_dut( unsigned int* a, unsigned int* d );
extern "C" void read_dut( unsigned int* a, unsigned int* d );


Server *server;


int startServer()
{
  server = new Server("RW");
  server->start();
  return 0;
}


int acceptNewSocket() {
  int new_socket;

  new_socket = server->acceptNewSocket();

  if (new_socket >= 0) {
    //---------------------------------------------
    // processing command from client
    //---------------------------------------------
    uint32_t read_buf[3];
    // -- read_buf[0]: rwB
    // -- read_buf[1]: address
    // -- read_buf[2]: write data (if rwB=0)
    uint32_t send_buf[1];
    // -- send_buf[0]: read data
    read(new_socket , read_buf, sizeof(read_buf));
    if (read_buf[1] >= 1<<8)
      printf("Warning: address=0x%x, but DUT mem size is 256*32b\n", read_buf[1]);
    if (read_buf[0] == 0) {
      write_dut(&read_buf[1], &read_buf[2]);
    } else {
      read_dut(&read_buf[1], &send_buf[0]);
      send(new_socket, send_buf, sizeof(send_buf) , 0);
    }
    //---------------------------------------------
  }

  return 0;
}
