interface dut_if();
  logic clk, rst_n;
  logic in_rdy, in_vld;
  logic [31:0] in_data;
  logic out_rdy, out_vld;
  logic [31:0] out_data;
endinterface

module dut(dut_if dif);

  bit [31:0] out_data_q[$], garbage;

  always @(posedge dif.clk)
  begin
    if (!dif.rst_n)
    begin
      dif.out_data    <= 32'b0;
      dif.out_vld     <= 32'b0;
      dif.in_rdy      <= 32'b0;
    end
    else
    begin
      // in
      dif.in_rdy <= $urandom;
      if (dif.in_rdy && dif.in_vld)
      begin
        out_data_q.push_back(dif.in_data);
      end
      // out
      if (out_data_q.size() != 0)
      begin
        dif.out_data <= out_data_q[0];
        dif.out_vld  <= $urandom;
      end
      else
      begin
        dif.out_data <= 32'bx;
        dif.out_vld  <= 1'b0;
      end
      if (dif.out_rdy && dif.out_vld)
        void'(out_data_q.pop_front());
    end
  end
endmodule
