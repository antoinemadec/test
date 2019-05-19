module fifo #(parameter SIZE_LOG2 = 4)
  (
    input         clk,
    input         rstB,
    input [31:0]  in_data,
    input         in_vld,
    output        in_rdy,
    output [31:0] out_data,
    output        out_vld,
    input         out_rdy
  );
  logic [SIZE_LOG2-1:0] wp, rp;
  logic [SIZE_LOG2:0] cnt;
  logic [31:0] mem[1<<SIZE_LOG2];

  assign in_rdy = (cnt != 1<<SIZE_LOG2);
  assign out_vld = (cnt != 0);
  assign out_data = mem[rp];

  always @(posedge clk)
  begin
    if (!rstB)
    begin
      rp <= 0;
      wp <= 0;
      cnt <= 0;
    end
    else
    begin
      // pointers
      if (in_vld && in_rdy)
      begin
        mem[wp] <= in_data;
        wp <= wp + 1;
      end
      if (out_vld && out_rdy)
        rp <= rp + 1;
      // counter
      if (!(in_vld && in_rdy && out_vld && out_rdy))
      begin
        if (in_vld && in_rdy)
          cnt <= cnt + 1;
        if (out_vld && out_rdy)
          cnt <= cnt - 1;
      end
    end
  end
endmodule
