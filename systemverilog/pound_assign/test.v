module main();

  reg in;
  bit clk;
  initial forever #1 clk ++;

  assign #10 out_pound_assign = in;
  // assign in_pound_assign = #10 in;  // not legal
  reg out_pound_reg;
  reg in_pound_reg;
  always @(posedge clk)
  begin
    #10 out_pound_reg <= in;
    in_pound_reg      <= #10 in;
  end

  initial
  begin
    $display("-- #5 changes");
    in = 0;
    #5;
    in = 1;
    #5;
    in = 0;
    #5;
    in = 1;
    #5;
    $display("-- #10 changes");
    in = 0;
    #10;
    in = 1;
    #10;
    in = 0;
    #10;
    in = 1;
    #10;
    $display("-- #20 changes");
    in = 0;
    #20;
    in = 1;
    #20;
    in = 0;
    #20;
    in = 1;
    #20;
    #100;
    $finish();
  end

  initial
  begin
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end
endmodule
