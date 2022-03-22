// This is the SystemVerilog interface that we will use to connect
// our design to our UVM testbench.
interface dut_if;
  logic clock, reset;
  logic rwb;
  logic [7:0] addr;
  logic [7:0] wdata;
  logic [7:0] rdata;
endinterface


// This is our design module.
//
// It is an empty design that simply prints a message whenever
// the clock toggles.
module dut(dut_if dif);
  import uvm_pkg::*;
  reg[7:0] mem[256];
  always @(posedge dif.clock)
    if (dif.reset)
      dif.rdata <= 8'b0;
    else
    begin
      if (dif.rwb)
        dif.rdata <= mem[dif.addr];
      else
        mem[dif.addr] <= dif.wdata;
    end
endmodule
