import "DPI-C" function real get_current_time_in_sec();
import "DPI-C" function void print_bandwidth(real t0, real t1, int bytes);

`define CYCLES 100000000

module top ();
  initial begin
    real t0;
    real t1;
    int s;
    s = 0;

    t0 = get_current_time_in_sec();
    $display("t0=%.3f", t0);
    for (int i = 0; i < `CYCLES; i++) begin
      int a;
      int b;
      // Simulate some computation
      a = i * 2;
      b = a + 3;
      s = s + b;
    end
    t1 = get_current_time_in_sec();
    $display("t1=%.3f", t1);
    $display("SV: final sum=%0d", s);
    print_bandwidth(t0, t1, 1);

    $finish;
  end
endmodule
