class node;

  string name;
  node next;

  function new(string name);
    this.name = name;
  endfunction

  function node get_next();
    return next;
  endfunction

  function void set_next(node  n);
    next = n;
  endfunction

  function void disp();
    $display(name);
  endfunction

endclass


module main();
  bit clk;
  initial
  forever #5 clk = ~clk;

  function void print_list(node n);
    while (n!=null)
    begin
      n.disp();
      n = n.get_next();
    end
  endfunction

  function void revert_list(node n);
    node n_p2, n_p1;
    n_p2 = null;
    n_p1 = null;
    while (n!=null)
    begin
      n_p2 = n_p1;
      n_p1 = n;
      n    = n.get_next();
      if (n_p1 != null)
        n_p1.set_next(n_p2);
    end
    n_p1.set_next(n_p2);
  endfunction

  initial
  begin
    node n0, n1, n2, n3;
    n0 = new("a");
    n1 = new("b");
    n2 = new("c");
    n3 = new("d");
    n0.set_next(n1);
    n1.set_next(n2);
    n2.set_next(n3);
    n3.set_next(null);
    print_list(n0);
    revert_list(n0);
    print_list(n3);
    $finish();
  end

  initial
  begin
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end
endmodule
