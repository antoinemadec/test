module main();


  bit clk;
  initial
  forever #5 clk = ~clk;

  function void disp(int th);
    for (int i=0; i<10; i++)
      $display("th%0d: %0d", th, i);
  endfunction

  initial
  begin
    fork
      forever @(clk)
        disp(0);
      forever @(posedge clk)
        disp(1);
      forever @(negedge clk)
        disp(2);
      forever @(clk)
        disp(3);
      forever @(posedge clk)
        disp(4);
      forever @(negedge clk)
        disp(5);
      #100 $finish();
    join
  end
endmodule
