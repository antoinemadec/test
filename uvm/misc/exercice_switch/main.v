`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"

module main();
  import uvm_pkg::*;
  import my_testbench_pkg::*;

  bit clk;
  initial
    forever #5 clk ++;

  network_if i0(clk);
  network_if i1(clk);
  network_if o0(clk);
  network_if o1(clk);

  dut dut(i0,i1,o0,o1);

  initial
  begin
    uvm_config_db #(virtual network_if)::set(null, "*", "vif_i0", i0);
    uvm_config_db #(virtual network_if)::set(null, "*", "vif_i1", i1);
    uvm_config_db #(virtual network_if)::set(null, "*", "vif_o0", o0);
    uvm_config_db #(virtual network_if)::set(null, "*", "vif_o1", o1);
    run_test("my_test");
  end

  // Dumping
  initial
  begin
    $shm_open("verilog.shm", 0, 2*1073741824);
    $shm_probe(main, "ACSM");
  end

endmodule
