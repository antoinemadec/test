module top #(
    parameter int CPU_NB = 4
);

  bit clk = 0;
  always #1ns clk <= ~clk;

  noc_dpi_server #(.CPU_NB(CPU_NB)) i_noc_dpi_server (.clk(clk));

endmodule
