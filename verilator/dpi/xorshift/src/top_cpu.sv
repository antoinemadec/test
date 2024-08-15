import "DPI-C" function int dpi_cpu_client_start(
  int idx,
  string server_address,
  int server_port
);
import "DPI-C" function void dpi_cpu_client_send_data(input bit [63:0] data);

module top_cpu #(
    parameter int CPU_INDEX   = 0,
    parameter int SERVER_PORT = 8100
);
  bit clk = 0;
  always #1ns clk <= ~clk;

  bit data_vld;
  bit [63:0] data;
  bit transactions_done;

  cpu #(
      .CPU_INDEX(CPU_INDEX)
  ) cpu (
      .clk              (clk),
      .data_vld         (data_vld),
      .data             (data),
      .transactions_done(transactions_done)
  );

  initial begin
    $display("CPU_INDEX=%0d", CPU_INDEX);
    while (dpi_cpu_client_start(
        CPU_INDEX, "127.0.0.1", SERVER_PORT
    ) != 1) begin
      ;
    end
    wait(transactions_done);
    $finish;
  end

  always_ff @(posedge clk) begin
    if (data_vld) begin
      dpi_cpu_client_send_data(data);
    end
  end
endmodule
