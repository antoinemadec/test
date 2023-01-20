module top(
  input clk,
  input rstn,
  input [3:0] n,
  output reg [7:0] n2
);

  top_core_normal top_core_0(
    .clk  (clk ),
    .rstn (rstn),
    .n    (n   ),
    .n2   (n2  )
  );

  wire [3:0] n_dummy = n;
  reg [7:0] n2_dummy;

  top_core_different_interface top_core_1(
    .clk  (clk ),
    .rstn (rstn),
    .n    (n_dummy ),
    .n2   (n2_dummy )
  );

endmodule
