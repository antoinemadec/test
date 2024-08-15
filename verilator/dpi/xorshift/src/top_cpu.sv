import "DPI-C" context task dpi_cpu_start_server(int idx);
import "DPI-C" function void dpi_cpu_send_data(input bit [63:0] data);

module top_cpu #(parameter int CPU_INDEX = 0);
  bit clk = 0;
  always #1ns clk <= ~clk;

  localparam int Seed = 64'hdeadbeefdeadbeef + CPU_INDEX;
  bit data_vld;
  bit [63:0] data;

  cpu #(
      .SEED(Seed)
  ) cpu (
      .clk     (clk),
      .data_vld(data_vld),
      .data    (data)
  );

  // TODO: move in top.sv
  initial begin
    dpi_cpu_start_server(CPU_INDEX);
  end

  always_ff @(posedge clk) begin
    if (data_vld) begin
      dpi_cpu_send_data(data);
    end
  end
endmodule
