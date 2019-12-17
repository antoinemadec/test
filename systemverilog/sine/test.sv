// TODO: not working

module cos(
  input         clk,
  input         rstB,
  output signed [31:0] out
);
  logic signed [31:0] a, b;
  derivative#(0, (1<<20)-1) d0(clk, rstB, -a, b);
  derivative#(1<<20, -(1<<10)) d1(clk, rstB, b, a);

  assign out = a;
endmodule

module derivative #(
  parameter logic signed [31:0] INIT_MEM = 0,
  parameter logic signed [31:0] INIT_OUT = 0
)
  (
    input         clk,
    input         rstB,
    input signed [31:0]  in,
    output reg signed [31:0] out
  );

  logic signed [31:0] mem;

  always @(posedge clk)
  begin
    if (!rstB)
    begin
      mem <= INIT_MEM;
      out <= INIT_OUT;
    end
    else
    begin
      out <= (in - mem)<<10;
      mem <= in;
    end
  end
endmodule

module top();

  bit clk;
  bit rstB;

  always
    #5 clk = ~clk;

  logic signed [31:0] out;
  cos cos(clk, rstB, out);

  initial
  begin
    rstB <= 0;
    repeat(10) @(posedge clk);
    rstB <= 1;
    repeat(1000) @(posedge clk);
    $finish;
  end

  initial
  begin
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end
endmodule
