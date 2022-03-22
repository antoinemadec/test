interface network_if(input clk);
  logic rstn;
  logic rdy, vld;
  logic [32+2-1:0] data;

  function bit get_src();
    return data[33];
  endfunction
  function bit get_dst();
    return data[32];
  endfunction

  modport OUT(
    input clk, rstn, rdy,
    output data, vld
    );
  modport IN(
    input clk, rstn, vld, data,
    output rdy,
    import get_src, get_dst
    );
endinterface


module dut(
  network_if.IN  i0, i1,
  network_if.OUT o0, o1
  );

  bit o0_sel, o1_sel;   // choose which input fifo to pop
  wire [33:0] i00_data, o00_data;
  wire        i00_vld,  o00_vld;
  wire        i00_rdy,  o00_rdy;
  wire [33:0] i01_data, o01_data;
  wire        i01_vld,  o01_vld;
  wire        i01_rdy,  o01_rdy;
  wire [33:0] i10_data, o10_data;
  wire        i10_vld,  o10_vld;
  wire        i10_rdy,  o10_rdy;
  wire [33:0] i11_data, o11_data;
  wire        i11_vld,  o11_vld;
  wire        i11_rdy,  o11_rdy;

  assign o0.rstn = i0.rstn;
  assign o1.rstn = i1.rstn;

  assign i00_data = (i0.get_dst()==0 ? i0.data:34'hx);
  assign i00_vld  = (i0.get_dst()==0 ? i0.vld:1'b0);
  assign i01_data = (i0.get_dst()==1 ? i0.data:34'hx);
  assign i01_vld  = (i0.get_dst()==1 ? i0.vld:1'b0);
  assign i0.rdy   = (i0.get_dst()==0 ? i00_rdy:1'b0) || (i0.get_dst()==1 ? i01_rdy:1'b0);

  assign i10_data = (i1.get_dst()==0 ? i1.data:34'hx);
  assign i10_vld  = (i1.get_dst()==0 ? i1.vld:1'b0);
  assign i11_data = (i1.get_dst()==1 ? i1.data:34'hx);
  assign i11_vld  = (i1.get_dst()==1 ? i1.vld:1'b0);
  assign i1.rdy   = (i1.get_dst()==0 ? i10_rdy:1'b0) || (i1.get_dst()==1 ? i11_rdy:1'b0);

  assign o0.data  = o0_sel ? o10_data:o00_data;
  assign o0.vld   = o0_sel ? o10_vld:o00_vld;
  assign o00_rdy  = o0_sel ? 0:o0.rdy;
  assign o10_rdy  = o0_sel ? o0.rdy:0;

  assign o1.data  = o1_sel ? o11_data:o01_data;
  assign o1.vld   = o1_sel ? o11_vld:o01_vld;
  assign o01_rdy  = o1_sel ? 0:o1.rdy;
  assign o11_rdy  = o1_sel ? o1.rdy:0;

  fifo f00(
    .clk      (i0.clk  ),
    .rstn     (i0.rstn ),
    .in_data  (i00_data),
    .in_vld   (i00_vld ),
    .in_rdy   (i00_rdy ),
    .out_data (o00_data),
    .out_vld  (o00_vld ),
    .out_rdy  (o00_rdy )
    );
  fifo f01(
    .clk      (i0.clk  ),
    .rstn     (i0.rstn ),
    .in_data  (i01_data),
    .in_vld   (i01_vld ),
    .in_rdy   (i01_rdy ),
    .out_data (o01_data),
    .out_vld  (o01_vld ),
    .out_rdy  (o01_rdy )
    );
  fifo f10(
    .clk      (i1.clk  ),
    .rstn     (i1.rstn ),
    .in_data  (i10_data),
    .in_vld   (i10_vld ),
    .in_rdy   (i10_rdy ),
    .out_data (o10_data),
    .out_vld  (o10_vld ),
    .out_rdy  (o10_rdy )
    );
  fifo f11(
    .clk      (i1.clk  ),
    .rstn     (i1.rstn ),
    .in_data  (i11_data),
    .in_vld   (i11_vld ),
    .in_rdy   (i11_rdy ),
    .out_data (o11_data),
    .out_vld  (o11_vld ),
    .out_rdy  (o11_rdy )
    );

  always @(posedge i0.clk)
  begin
    o0_sel <= $urandom;
    o1_sel <= $urandom;
  end
endmodule


module fifo(
  input             clk,
  input             rstn,
  input [33:0]      in_data,
  input             in_vld,
  output reg        in_rdy,
  output reg [33:0] out_data,
  output reg        out_vld,
  input             out_rdy
  );

  logic [33:0] q[$];

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
