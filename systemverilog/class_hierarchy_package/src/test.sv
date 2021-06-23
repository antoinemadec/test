module dut();
  bit [31:0]    data;
  initial begin
    data <= 'h0;
  end
endmodule


module test();
  import test_pkg::*;

  dut dut();

  initial
  begin
    Test t;
    t = new();
    #10;
    fork
      t.run();
    join_none
    #10;
    dut.data <= 'hdeadbeef;
    #10;
    dut.data <= 'h0;
    #10;
    dut.data <= 'hcafedeca;
  end

endmodule
