// ##1 notation requires a clocking block
interface i(input clk);
  integer d,c;
  logic vld;

  default clocking cb @(posedge clk);
    inout c;
    output d, vld;
  endclocking
endinterface


module main();

  task burst(int n);
    repeat (n)
    begin
      i.cb.d <= ##1 i.cb.c;
      i.cb.vld <= 1;
      @(i.cb);
    end
    i.cb.vld <= 0;
    i.cb.d <= ##1 32'hx;
  endtask


  bit clk;
  initial
  forever #5 clk = ~clk;

  i i(clk);

  initial
  begin
    i.c = 0;
    forever @(i.cb)
    i.c <= i.c + 1;
  end

  initial
  begin
    fork
      begin
        @(i.cb);
        burst(4);
        @(i.cb);
        burst(4);
        burst(4);
        @(i.cb);
      end
      begin
        #1000;
        $finish();
      end
    join_none
  end

  initial
  begin
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end
endmodule
