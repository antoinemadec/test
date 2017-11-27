interface itf(input clk);
  int cnt;

  clocking cb @(posedge clk);
    output cnt;
  endclocking
endinterface


class monitor;
  virtual interface itf i;
  task run();
    $display("#================================================");
    $display("# mixing cb and posedge clk");
    $display("#================================================");
    repeat (4)
    begin
      @(posedge i.clk);
      $display("t=%t; i.cnt=%0d (@(posedge i.clk))", $time, i.cnt);
      @(i.cb);
      $display("t=%t; i.cnt=%0d (@(i.cb))", $time, i.cnt);
    end
    $display("#================================================");
    $display("# mixing cb and posedge clk (inverse)");
    $display("#================================================");
    repeat (4)
    begin
      @(i.cb);
      $display("t=%t; i.cnt=%0d (@(i.cb))", $time, i.cnt);
      @(posedge i.clk);
      $display("t=%t; i.cnt=%0d (@(posedge i.clk))", $time, i.cnt);
    end
    $display("#================================================");
    $display("# only cb");
    $display("#================================================");
    repeat (4)
    begin
      @(i.cb);
      $display("t=%t; i.cnt=%0d (@(i.cb))", $time, i.cnt);
    end
    $display("#================================================");
    $display("# only clk");
    $display("#================================================");
    repeat (4)
    begin
      @(posedge i.clk);
      $display("t=%t; i.cnt=%0d (@(posedge i.clk))", $time, i.cnt);
    end
  endtask
endclass


module main();
  bit clk;
  initial
  forever #5 clk = ~clk;

  itf i(clk);

  initial
  forever @(i.cb)
    i.cnt <= i.cnt + 1;

  initial
  begin
    monitor mon;
    mon = new();
    mon.i = i;
    mon.run();
    $finish();
  end

  initial
  begin
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end
endmodule
