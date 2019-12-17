module top();

  import "DPI-C" function void c_print();

  initial
  begin
    #100;
    repeat(10)
    begin
      $display("Printed from Verilog");
      c_print();
    end
    #100;
    $finish();
  end
endmodule
