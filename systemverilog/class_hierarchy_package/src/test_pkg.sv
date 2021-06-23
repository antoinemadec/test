package test_pkg;
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
endpackage
