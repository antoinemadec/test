`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"

module main();
  import uvm_pkg::*;
  import my_testbench_pkg::*;

  dut_if dut_if0();
  dut dut(.dif(dut_if0));

  initial
  begin
    dut_if0.clk = 0;
    forever #5 dut_if0.clk ++;
  end

  initial
  begin
    uvm_config_db #(virtual dut_if)::set(null, "*", "dut_vif", dut_if0);
    run_test("my_test");
  end

  // Dumping
  initial
  begin
    $shm_open("verilog.shm", 0, 2*1073741824);
    $shm_probe(main, "AC");
  end

endmodule
