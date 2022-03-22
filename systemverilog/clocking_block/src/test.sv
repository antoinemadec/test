interface itf(input clk);
  wire [31:0] data;
  reg  [31:0] data2;
  reg         vld;

  clocking cb @(posedge clk);
    inout data;
    inout vld;
    inout data2;
  endclocking
endinterface


class monitor;
  virtual interface itf i;

  task run();
    $display("---- good CB");
    repeat (10) begin
      @(i.cb);
      if (i.cb.vld) begin
        $display("t=%t; cb.data=%0d cb.data2=%0d", $time, i.cb.data, i.cb.data2);
      end
    end

    $display("---- bad CB_VLD");
    repeat (10) begin
      @(i.cb.vld);
      if (i.cb.vld) begin
        $display("t=%t; cb.data=%0d cb.data2=%0d", $time, i.cb.data, i.cb.data2);
      end
    end

    $display("---- bad POS CB_VLD");
    repeat (5) begin
      @(posedge i.cb.vld);
      $display("t=%t; cb.data=%0d cb.data2=%0d", $time, i.cb.data, i.cb.data2);
    end

    $display("---- bad CB_DATA only");
    repeat (10) begin
      @(i.vld);
      if (i.vld) begin
        $display("t=%t; cb.data=%0d cb.data2=%0d", $time, i.cb.data, i.cb.data2);
      end
    end

    $display("---- bad no CB");
    repeat (5) begin
      @(posedge i.vld);
      $display("t=%t; data=%0d data2=%0d", $time, i.data, i.data2);
    end
  endtask
endclass


module main();
  bit clk;
  initial
  forever #5 clk = ~clk;

  itf i(clk);

  // clean
  initial begin
    @(i.cb);
    i.cb.data <= 0;
    @(i.cb);
    forever begin
      i.cb.data <= i.cb.data + 1;
      @(i.cb);
    end
  end

  // dirty
  initial begin
    int cnt = 0;
    @(posedge clk);
    i.data2 <= 0;
    i.vld <= 0;
    @(posedge clk);
    forever begin
      cnt++;
      #1 i.vld <= cnt%3 != 0;
      #2 i.data2 <= i.data2 + 1;
      @(posedge clk);
    end
  end

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
