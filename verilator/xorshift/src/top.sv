module top #(
    parameter int CPU_NB = 4
);
  bit clk = 0;
  always #1ns clk <= ~clk;

  bit [CPU_NB-1:0] transactions_done;

  for (genvar cpu_idx = 0; cpu_idx < CPU_NB; cpu_idx++) begin : gen_cpu
    bit data_vld;
    bit [63:0] data;
    int transaction_idx = 0;

    cpu #(
        .CPU_INDEX(cpu_idx)
    ) cpu (
        .clk     (clk),
        .data_vld(data_vld),
        .data    (data),
      .transactions_done(transactions_done[cpu_idx])
    );

    always @(posedge clk) begin
      if (data_vld) begin
        $display("[cpu_%0d] top read 0x%016x", cpu_idx, data);
      end
    end
  end

  initial begin
    wait (transactions_done == {CPU_NB{1'b1}});
    repeat (2) @(posedge clk);
    $finish;
  end

endmodule
