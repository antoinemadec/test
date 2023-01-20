module wrapper(
  input clk,
  input rstn,
  input [3:0] n,
  output reg [7:0] n2
);
  top top(
    .clk  (clk ),
    .rstn (rstn),
    .n    (n   ),
    .n2   (n2  )
  );
endmodule


module test();

  bit clk;
  bit rstn;
  reg [3:0] n;
  wire [7:0] n2;

  wrapper wrapper(
    .clk  (clk ),
    .rstn (rstn),
    .n    (n   ),
    .n2   (n2  )
  );

  // clock
  always #5 clk = ~clk;

  // execution
  initial begin
    $display("start test");
    rstn = 0;
    #100;
    rstn = 1;
    #100;
    for (int i = 0; i < 256; i++) begin
      n <= i;
      @(posedge clk);
    end
    #100;
    $finish();
  end

  // waves
  initial begin
    $fsdbDumpvars(0, "+all");
  end
endmodule
