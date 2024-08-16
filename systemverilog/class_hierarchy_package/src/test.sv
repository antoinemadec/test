package test_pkg;
  class Test;
    function new();
    endfunction

    task run();
      forever begin
        wait ($root.test.dut.data !== 0);
        $display("data=0x%0x", $root.test.dut.data);
        wait ($root.test.dut.data === 0);
      end
    endtask
  endclass
endpackage


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
