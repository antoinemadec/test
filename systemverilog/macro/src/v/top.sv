module sub();
  function p();
    $display("sub: %m");
  endfunction
endmodule


module top();
  `define FOO 2
  `define BAR 9

  `define my_print(d) \
    $display(`"``d`", "=%0d", `d);

  `define PATH(d) sub``d``

  sub sub0();
  sub sub1();

  initial
  begin
    #100;
    `my_print(FOO)
    `my_print(BAR)
    #100;
    void'(`PATH(0).p());
    void'(`PATH(1).p());
    $finish();
  end
endmodule
