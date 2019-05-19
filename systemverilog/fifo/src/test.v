module test();
  bit           clk;
  logic         rstB;
  logic [31:0]  in_data;
  logic         in_vld;
  wire          in_rdy;
  wire [31:0]   out_data;
  wire          out_vld;
  logic         out_rdy;

  fifo fifo(
    .clk      (clk     ),
    .rstB     (rstB    ),
    .in_data  (in_data ),
    .in_vld   (in_vld  ),
    .in_rdy   (in_rdy  ),
    .out_data (out_data),
    .out_vld  (out_vld ),
    .out_rdy  (out_rdy )
  );

  task push(input [31:0] data);
    in_data <= data;
    in_vld <= 1'b1;
    @(posedge clk);
    while (!in_rdy)
      @(posedge clk);
    in_data <= 32'hx;
    in_vld <= 1'b0;
  endtask

  task pull();
    out_rdy <= 1'b1;
    @(posedge clk);
    while (!out_vld)
      @(posedge clk);
    out_rdy <= 1'b0;
  endtask

  initial
  begin
    forever
    begin
      #5 clk = ~clk;
    end
  end

  initial
  begin
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
    // scenario
    fork
      forever
        pull();
    join_none
    rstB <= 1'b0;
    repeat(10) @(posedge clk);
    rstB <= 1'b1;
    for (int i=0; i<128; i++)
      push(i);
  end

endmodule
