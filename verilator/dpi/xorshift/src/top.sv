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

  localparam int TransactionNbPerCpu = 1000;

  bit [CPU_NB-1:0] transactions_done;

  for (genvar cpu_idx = 0; cpu_idx < CPU_NB; cpu_idx++) begin : gen_cpu
    int data_vld;
    bit [63:0] data;
    int transaction_idx = 0;

    bit server_has_started = 0;
    initial begin
      dpi_cpu_server_start(cpu_idx);
      server_has_started = 1;
    end

    always @(posedge clk) begin
      bit [63:0] data;
      if (server_has_started) begin
        data_vld = dpi_cpu_server_get_data(cpu_idx, data);
        if (data_vld == 1 && !transactions_done[cpu_idx]) begin
          $display("[cpu_%0d] 0x%016x (transaction %0d/%0d)", cpu_idx, data, transaction_idx,
                   TransactionNbPerCpu);
          transaction_idx <= transaction_idx + 1;
          if (transaction_idx == (TransactionNbPerCpu - 1)) begin
            transactions_done[cpu_idx] <= 1;
          end
        end
      end
    end
  end

  initial begin
    wait (transactions_done == {CPU_NB{1'b1}});
    $finish;
  end

endmodule
