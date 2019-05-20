module div6(
  input clk,
  input rstB,
  output clk_div6
);
  logic [2:0] cnt;
  assign clk_div6 = (cnt < 3) & rstB;

  always @(posedge clk)
  begin
    if (!rstB)
    begin
      cnt <= 0;
    end
    else
    begin
      if (cnt == 5)
        cnt <= 0;
      else
        cnt <= cnt + 1;
    end
  end
endmodule


module div3(
  input clk,
  input rstB,
  output clk_div3
);
  logic [1:0] cnt;
  assign clk_div3 = (cnt == 0) && rstB;

  always @(posedge clk)
  begin
    if (!rstB)
    begin
      cnt <= 0;
    end
    else
    begin
      if (cnt == 2)
        cnt <= 0;
      else
        cnt <= cnt + 1;
    end
  end
endmodule


module div3_50(
  input clk,
  input rstB,
  output clk_div3
);
  logic clk0, clk1;

  assign clk_div3 = clk0 || clk1;

  div3 div3_0(
    .clk      (clk ),
    .rstB     (rstB),
    .clk_div3 (clk0)
  );

  div3 div3_1(
    .clk      (~clk),
    .rstB     (rstB),
    .clk_div3 (clk1)
  );
endmodule


module test();
  bit           clk;
  logic         rstB;
  logic         clk_div3;
  logic         clk_div6;

  div6 div6(
    .clk      (clk     ),
    .rstB     (rstB    ),
    .clk_div6 (clk_div6)
  );

  div3_50 div3_50(
    .clk      (clk     ),
    .rstB     (rstB    ),
    .clk_div3 (clk_div3)
  );

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
    rstB <= 1'b0;
    repeat(10) @(posedge clk);
    rstB <= 1'b1;
    repeat(100) @(posedge clk);
    $finish;
  end

endmodule
