module fifo(
  input         clk,
  input         rstB,
  input [31:0]  in_data,
  input         in_vld,
  output        in_rdy,
  output [31:0] out_data,
  output        out_vld,
  input         out_rdy
);
  logic[31:0] wp, rp;

  // assign in_rdy = rp;
  // assign out_vld = ;

  always @(posedge clk)
  begin
    if (!rstB)
    begin
      rp <= 0;
      wp <= 0;
    end
    else
    begin
      $display("COUCOU");
    end
  end
endmodule
