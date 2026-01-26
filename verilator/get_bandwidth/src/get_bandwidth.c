#include <stdint.h>
#include <stdio.h>
#include <sys/time.h>

extern "C" double get_current_time_in_sec();

extern "C" void print_bandwidth(double start, double stop, uint32_t byte_nb);

double get_current_time_in_sec() {
  struct timeval current_time;
  gettimeofday(&current_time, NULL);
  return (double)(current_time.tv_usec) / 1000000 + (double)(current_time.tv_sec);
}

void print_bandwidth(double start, double stop, uint32_t byte_nb) {
  double secs = stop - start;
  printf("time: %.3f s\n", secs);
  printf("byte_nb: %d\n", byte_nb);
  printf("BW = %0d B/sec\n", (uint32_t)(byte_nb / secs));
}
