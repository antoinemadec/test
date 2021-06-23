class Test;
  function new();
  endfunction

  task run();
    forever begin
      wait (test.dut.data !== 0);
      $display("data=0x%0x", test.dut.data);
      wait (test.dut.data === 0);
    end
  endtask
endclass


module dut();
  bit [31:0]    data;
  initial begin
    data <= 'h0;
  end
endmodule


module test();

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
