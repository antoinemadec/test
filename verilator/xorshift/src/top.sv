module top ();
  bit clk = 0;
  always #1ns clk <= ~clk;

  bit data_vld;
  bit [63:0] data;

  for (genvar i = 0; i<16; i++) begin: gen_cpu
    cpu #(
      .SEED(64'hdeadbeefdeadbeef)
    ) cpu (
      .clk     (clk),
      .data_vld(data_vld),
      .data    (data)
    );

    int data_cnt = 0;

    always_ff @(posedge clk) begin
      if (data_vld) begin
        $display("[%m] 0x%016x", data);
        data_cnt <= data_cnt + 1;
      end
    end

    initial begin
      wait (data_cnt == 1000);
      $finish;
    end
  end

endmodule
