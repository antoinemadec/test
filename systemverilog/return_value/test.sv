module main();
  initial
  begin
    #10;
    // $error("error");             // error code; don't stop simulation
    #10;
    $display("foo");
    #10;
    // $finish(0);                  // no error code unless error;
    // $finish(1);                  // no error code unless error; add sim time and location
    // $finish(2);                  // no error code unless error; add sim time, location, stats MEM/CPU
    // $fatal(0, "fatal error 0");  // error code;
    // $fatal(1, "fatal error 1");  // error code; add sim time and location
    // $fatal(2, "fatal error 2");  // error code; add sim time, location, stats MEM/CPU
    $finish();
  end
endmodule
