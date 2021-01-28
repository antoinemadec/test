class Toto;
  function new();
  endfunction

  task run();
    test.write_data(32'hcafedeca);
    test.read_data();
  endtask
endclass

module test();
  bit           clk;
  logic         rstB;
  bit [31:0]    data;

  task write_data(bit[31:0] d);
    data <= d;
    @(posedge clk);
  endtask

  function void read_data();
    $display("rdata=0x%x", data);
  endfunction

  initial
  begin
    forever
    begin
      #5 clk = ~clk;
    end
  end

  initial
  begin
    Toto t;
    t = new();
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
    rstB <= 1'b0;
    repeat(10) @(posedge clk);
    rstB <= 1'b1;
    repeat(10) @(posedge clk);
    t.run();
    repeat(100) @(posedge clk);
    $finish;
  end

endmodule
