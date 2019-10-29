interface foo_if(input clk);
  wire [31:0] data_out;

  clocking drv_cb @(posedge clk);
    output data_out;
  endclocking

  clocking mon_cb @(posedge clk);
    input data_out;
  endclocking
endinterface


module mon(foo_if foo_if);
  always @(foo_if.mon_cb)
  begin
    $display("data_out = 0x%x", foo_if.mon_cb.data_out);
  end
endmodule


module top();
  bit clk;
  initial
  begin
    forever
    begin
      #5 clk = ~clk;
    end
  end

  foo_if foo_if(clk);
  mon mon(foo_if);

  initial
  begin
    reg [31:0] data_out;
    @(posedge clk);
    data_out = 32'hcafedeca;
    repeat (10)
    begin
      foo_if.drv_cb.data_out <= data_out;
      @(posedge clk);
      data_out ++;
    end
    $finish();
  end
endmodule
