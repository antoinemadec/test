module ram(input clk);
  bit [31:0]    data;

  task write(bit[31:0] d);
    @(posedge clk);
    data <= d;
    @(posedge clk);
  endtask

  function void read();
    $display("%m rdata=0x%x", data);
  endfunction

  // function to be exported
  task test_access(bit[31:0] d);
    write(d);
    read();
  endtask
endmodule


bind ram ram_dpi ram_dpi();
module ram_dpi();
  export "DPI" task test_access_dpi_sv;
  task test_access_dpi_sv(bit[31:0] d);
    test_access(d);
  endtask
endmodule


module test();
  import test_pkg::*;

  bit clk;
  initial
  begin
    forever
    begin
      #5 clk = ~clk;
    end
  end

  ram ram0(clk);
  ram ram1(clk);
  ram ram2(clk);
  ram ram3(clk);
  ram ram4(clk);
  ram ram5(clk);
  ram ram6(clk);
  ram ram7(clk);

  initial
  begin
    Toto t;
    t = new();
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
    repeat(10) @(posedge clk);
    t.run();
    repeat(100) @(posedge clk);
    $finish;
  end

endmodule
