class M3x3;
  int m[3][3];
  string name;

  function new(string name="");
    this.name = name;
  endfunction

  // for shuffle
  rand int idx[9];
  constraint c {
    foreach (idx[i]) {
      idx[i] inside {[0:8]};
      foreach (idx[j])
        if (i!=j)
          idx[i] != idx[j];
    }
  }

  function void shuffle(M3x3 dst);
    assert(this.randomize());
    foreach (idx[i])
      dst.m[i/3][i%3] = this.m[idx[i]/3][idx[i]%3];
  endfunction

  function void print();
    $display("%s", name);
    for (int i=0; i<3; i++)
    begin
      for (int j=0; j<3; j++)
        $write("%3d ", m[i][j]);
      $write("\n");
    end
  endfunction
endclass


module main();
  bit clk;
  initial
  forever #5 clk = ~clk;

  M3x3 src, dst;

  initial
  begin
    src = new("src");
    dst = new("dst");
    src.m = '{'{0,1,2},'{3,4,5},'{6,7,8}};
    repeat (2)
    begin
      $display("---- contraint shuffle ----");
      src.shuffle(dst);
      src.print();
      dst.print();
    end
    dst.m = src.m;
    repeat (2)
    begin
      $display("---- systemverilog shuffle ----");
      dst.m.shuffle();
      src.print();
      dst.print();
    end
    $display("---- conclusion:                         ----");
    $display("----  arr.shuffle() works fine           ----");
    $display("----  matrix.shuffle() only shuffle rows ----");
    $finish();
  end
endmodule
