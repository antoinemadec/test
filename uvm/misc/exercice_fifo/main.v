`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"


module main();
  import uvm_pkg::*;
  import my_testbench_pkg::*;

  bit clk;

  initial
  begin
    forever #5 clk = ~clk;
  end

  fifo_if dif(clk);

  fifo fifo(
    .clk       (dif.clk       ),
    .rstn      (dif.rstn      ),
    .in_data   (dif.in_data   ),
    .in_vld    (dif.in_vld    ),
    .in_rdy    (dif.in_rdy    ),
    .out_data  (dif.out_data  ),
    .out_vld   (dif.out_vld   ),
    .out_rdy   (dif.out_rdy   )
    );

  initial
  begin
    uvm_config_db#(virtual fifo_if)::set(null,"*", "vif", dif);
    run_test("my_test");
  end

  // Dumping
  initial
  begin
    $shm_open("verilog.shm", 0, 2*1073741824);
    $shm_probe(main, "ACSM");
  end

endmodule
