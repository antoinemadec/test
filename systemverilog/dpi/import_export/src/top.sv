module top();

  // only context imported tasks may call exported tasks
  import "DPI-C" context task c_run();
  export "DPI-C" task sv_read;
  export "DPI-C" task sv_write;


  bit [31:0] arr[*];

  task sv_read(
    input int add,
    output int rdata
  );
    #10;
    rdata = arr[add];
    $display("SV: %0t ns    0x%x <- [0x%x]", $time, rdata, add);
  endtask: sv_read

  task sv_write(
    input int add,
    input int wdata
  );
    #10;
    arr[add] = wdata;
    $display("SV: %0t ns    0x%x -> [0x%x]", $time, wdata, add);
  endtask: sv_write


  initial
  begin
    c_run();
    $finish();
  end
endmodule
