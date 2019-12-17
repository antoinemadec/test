class FooParams;
  parameter A = 2;
  parameter B = 9;
endclass

class BarParams;
  parameter A = 9;
  parameter B = 8;
endclass

module my_mod #(type PARAMS=FooParams)
(
  input  [PARAMS::A-1:0] data_in,
  output [PARAMS::B-1:0] data_out
);
  function void disp();
    $display("%m: A=%0d ; B=%0d", PARAMS::A, PARAMS::B);
  endfunction
endmodule

class my_class #(type PARAMS=FooParams);
  parameter A = PARAMS::A;
  parameter B = PARAMS::B;

  bit [A-1:0] data_in;
  bit [B-1:0] data_out;

  function void disp();
    $display("%m: A=%0d ; B=%0d", A, B);
  endfunction
endclass

module main();

  my_mod #(FooParams) m0
  (
    .data_in  (data_in_0 ),
    .data_out (data_out_0)
  );
  my_mod #(BarParams) m1
  (
    .data_in  (data_in_1 ),
    .data_out (data_out_1)
  );
  my_class #(FooParams) c0;
  my_class #(BarParams) c1;

  initial
  begin
    c0 = new();
    c1 = new();
    #100;
    c0.disp();
    c1.disp();
    #100;
    m0.disp();
    m1.disp();
    #100;
    $finish();
  end

  initial
  begin
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end
endmodule
