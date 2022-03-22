interface fifo_if(input clk);
  logic rstn;
  logic in_rdy, in_vld;
  logic [31:0] in_data;
  logic out_rdy, out_vld;
  logic [31:0] out_data;
endinterface


module fifo(
  input             clk,
  input             rstn,
  input [31:0]      in_data,
  input             in_vld,
  output reg        in_rdy,
  output reg [31:0] out_data,
  output reg        out_vld,
  input             out_rdy
  );

  logic [31:0] q[$];

  always @(posedge clk)
  begin
    if (!rstn)
    begin
      in_rdy <= 0;
      out_vld <= 0;
    end
    else
    begin
      in_rdy <= 1;
      if (out_rdy && out_vld)
        void'(q.pop_front());
      if(q.size())
      begin
        out_data <= q[0];
        out_vld  <= 1;
      end
      else
      begin
        out_data <= 34'hx;
        out_vld  <= 0;
      end
      if (in_rdy && in_vld)
        q.push_back(in_data);
    end
  end
endmodule
