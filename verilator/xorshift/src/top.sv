module top ();
  bit clk = 0;
  always #1ns clk <= ~clk;

  localparam int TransactionNbPerCpu = 1000;

  for (genvar i = 0; i < 16; i++) begin : gen_cpu
    bit data_vld;
    bit [63:0] data;
    int transaction_idx = 0;
    parameter bit [63:0] SEED = 64'hdeadbeefdeadbeef + i;

    cpu #(
        .SEED(SEED)
    ) cpu (
        .clk     (clk),
        .data_vld(data_vld),
        .data    (data)
    );

    always_ff @(posedge clk) begin
      if (data_vld) begin
        $display("[%m] 0x%016x (transaction %0d/%0d)", data, transaction_idx, TransactionNbPerCpu);
        transaction_idx <= transaction_idx + 1;
      end
    end

    initial begin
      wait (transaction_idx == TransactionNbPerCpu);
      $finish;
    end
  end

endmodule
