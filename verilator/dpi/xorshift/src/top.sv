import "DPI-C" function void dpi_cpu_server_start(int idx);
import "DPI-C" function int dpi_cpu_server_get_data(
  int idx,
  output bit [63:0] data
);

module top #(
    parameter int CPU_NB = 4
);
  bit clk = 0;
  always #1ns clk <= ~clk;

  for (genvar cpu_idx = 0; cpu_idx < CPU_NB; cpu_idx++) begin : gen_cpu
    int data_vld;
    bit [63:0] data;

    bit server_has_started = 0;
    initial begin
      dpi_cpu_server_start(cpu_idx);
      server_has_started = 1;
    end

    always @(posedge clk) begin
      bit [63:0] data;
      if (server_has_started) begin
        data_vld = dpi_cpu_server_get_data(cpu_idx, data);
      end
    end
  end

  // TODO
  //initial begin
  //  wait (transactions_done == {CPU_NB{1'b1}});
  //  $finish;
  //end

endmodule
