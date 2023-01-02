module top();

  // only context imported tasks may call exported tasks
  import "DPI-C" context task c_init();
  import "DPI-C" context task c_fill_next_value();
  export "DPI-C" task sv_write;


  bit [31:0] arr[*];

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
    c_init();
    
    for (int i = 0; i < 10; i++) begin
      c_fill_next_value();
    end

    $finish();
  end
endmodule
