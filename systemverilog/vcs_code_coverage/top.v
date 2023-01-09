module top_core(
  input clk,
  input rstn,
  input [3:0] n,
  output reg [7:0] n2
);

always_ff @(posedge clk) begin
  if (rstn) begin
    n2 <= n*n;
  end
  else begin
    n2 <= 'hx;
  end
end
endmodule


module top(
  input clk,
  input rstn,
  input [3:0] n,
  output reg [7:0] n2
);

  top_core top_core_0(
    .clk  (clk ),
    .rstn (rstn),
    .n    (n   ),
    .n2   (n2  )
  );

  wire [3:0] n_dummy = n;
  reg [7:0] n2_dummy;

  top_core top_core_1(
    .clk  (clk ),
    .rstn (rstn),
    .n    (n_dummy ),
    .n2   (n2_dummy )
  );

endmodule
