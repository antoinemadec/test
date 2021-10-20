interface data_if(inout data);
  logic d;
  assign data = d;
endinterface

interface harness(inout data_in);
  data_if data_if(data_in);
endinterface


module dut(
  input data_in,
  output data_out
);
  assign data_out = data_in;
endmodule


// test
//  -> dut()
//    -> harness()
module test();

  dut dut();
  bind dut harness harness(.*);

  initial begin
    #10;
    dut.harness.data_if.d= 0;
    #10;
    dut.harness.data_if.d= 1;
    #10;
    dut.harness.data_if.d= 0;
    $finish;
  end

  // simvision
  initial
  begin
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end

endmodule
