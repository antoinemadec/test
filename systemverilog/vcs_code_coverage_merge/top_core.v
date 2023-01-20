module top_core(
  input clk,
  input rstn,
  input [3:0] n,
  output reg [7:0] n2
);

  wire [4:0] n_dummy = n;

always_ff @(posedge clk) begin
  if (rstn) begin
    n2 <= n*n;
  end
  else begin
    n2 <= 'hx;
  end
end
endmodule
