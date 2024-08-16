import "DPI-C" function int dpi_cpu_client_start(
  int idx,
  string server_address,
  int server_port
);
import "DPI-C" function void dpi_cpu_client_send_data(input bit [63:0] data);

module top_cpu;
  bit clk = 0;
  always #1ns clk <= ~clk;

  bit data_vld;
  bit [63:0] data;
  bit transactions_done;

  bit [31:0] cpu_index;
  bit [31:0] server_port;

  initial begin
    if (!$value$plusargs("CPU_INDEX=%d", cpu_index)) begin
      $fatal("+CPU_INDEX not set");
    end
    if (!$value$plusargs("SERVER_PORT=%d", server_port)) begin
      $fatal("+SERVER_PORT not set");
    end
    $display("CPU_INDEX=%0d", cpu_index);
    while (dpi_cpu_client_start(
        cpu_index, "127.0.0.1", server_port
    ) != 1) begin
      ;
    end
    wait (transactions_done);
    repeat (2) @(posedge clk);
    $finish;
  end

  cpu cpu (
      .clk              (clk),
      .cpu_index        (cpu_index),
      .data_vld         (data_vld),
      .data             (data),
      .transactions_done(transactions_done)
  );

  always_ff @(posedge clk) begin
    if (data_vld) begin
      dpi_cpu_client_send_data(data);
    end
  end
endmodule
