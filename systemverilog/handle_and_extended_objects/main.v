class Base;
  function void disp();
    $display("Base");
  endfunction
  virtual function void virtual_disp();
    $display("Virtual Base");
  endfunction
endclass

class Extended extends Base;
  int extended_var;
  function void disp();
    $display("Extended");
  endfunction
  virtual function void virtual_disp();
    $display("Virtual Extended");
  endfunction
endclass

module main();
  Base b, b_pe;
  Extended e, e_pb, e2;
  initial
  begin
    // normal usage
    b = new();
    e = new();
    b.disp();
    e.disp();

    // handle pointing on other objects
    // e_pb = b;                // Extended handles cannot point on base object
    b_pe = e;                   // Base handles can point on extended object
    b_pe.disp();                // use handle's method
    b_pe.virtual_disp();        // use object's method because it was defined with 'virtual'
    // b_pe.extended_var = 5;   // cannot access method/property only existing in extended object...

    // down casting: convert a based-class handle to a derived-class
    $cast(e2, b_pe);
    e2.extended_var = 5;        // ...have to downcast b_pe
    $display("var=%0d", e.extended_var);

    // up casting: convert a derived-class handle to a base-class
    $cast(b_pe, e);
    b_pe.virtual_disp();

    $finish;
  end
endmodule
