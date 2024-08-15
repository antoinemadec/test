module top();

  import "DPI-C" function int c_add(int a, int b);

  initial
  begin
    int sum;
    sum = c_add(3, 18);
    $display("SV: sum=%0d", sum);
    $finish();
  end
endmodule
