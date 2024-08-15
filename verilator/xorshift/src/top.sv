module top #(
    parameter int CPU_NB = 4
);
  bit clk = 0;
  always #1ns clk <= ~clk;

  localparam int TransactionNbPerCpu = 1000;

  bit [CPU_NB-1:0] transactions_done;

  for (genvar cpu_idx = 0; cpu_idx < CPU_NB; cpu_idx++) begin : gen_cpu
    bit data_vld;
    bit [63:0] data;
    int transaction_idx = 0;
    parameter bit [63:0] SEED = 64'hdeadbeefdeadbeef + cpu_idx;

    cpu #(
        .SEED(SEED)
    ) cpu (
        .clk     (clk),
        .data_vld(data_vld),
        .data    (data)
    );

    always_ff @(posedge clk) begin
      if (data_vld && !transactions_done[cpu_idx]) begin
        $display("[%m] 0x%016x (transaction %0d/%0d)", data, transaction_idx, TransactionNbPerCpu);
        transaction_idx <= transaction_idx + 1;
        if (transaction_idx == (TransactionNbPerCpu - 1)) begin
          transactions_done[cpu_idx] <= 1;
        end
      end
    end
  end

  initial begin
    wait (transactions_done == {CPU_NB{1'b1}});
    $finish;
  end

endmodule
