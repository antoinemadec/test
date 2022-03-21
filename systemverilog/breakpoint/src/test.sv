module top_tb();
  initial begin
    $display("start");
    #1000;
    $finish();
  end
endmodule
