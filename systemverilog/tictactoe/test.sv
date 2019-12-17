class tictactoe;
  rand bit [1:0] ttt[9];

  // used for computation
  rand bit [1:0] win_mask;
  rand bit       O_win;
  rand bit       X_win;
  rand int       O_nb;
  rand int       X_nb;

  // for stats
  int O_win_cnt;
  int X_win_cnt;
  int tie_cnt;

  constraint c {
    // each square is either empty, X or O
    foreach (ttt[i])
      ttt[i] != 2'b11;
    // compute win
    win_mask == (
      (ttt[0] & ttt[1] & ttt[2])  | // hori 0
      (ttt[3] & ttt[4] & ttt[5])  | // hori 1
      (ttt[6] & ttt[7] & ttt[8])  | // hori 2
      (ttt[0] & ttt[3] & ttt[6])  | // vert 0
      (ttt[1] & ttt[4] & ttt[7])  | // vert 1
      (ttt[2] & ttt[5] & ttt[8])  | // vert 2
      (ttt[0] & ttt[4] & ttt[8])  | // diag 0
      (ttt[2] & ttt[4] & ttt[6])    // diag 1
    );
    win_mask != 2'b11;
    O_win == win_mask[0];
    X_win == win_mask[1];
    // check O and X numbers
    O_nb == ttt.sum() with (int'(item[0]));
    X_nb == ttt.sum() with (int'(item[1]));
    O_nb <= X_nb + 1 - X_win;
    X_nb <= O_nb + 1 - O_win;
  }

  function post_randomize();
    if (O_win)
      O_win_cnt++;
    else if (X_win)
      X_win_cnt++;
    else tie_cnt++;
  endfunction

  function void disp();
    if (O_win)
      $display("O wins");
    else if (X_win)
      $display("X wins");
    else
      $display("tie");
    foreach (ttt[i])
    begin
      string square_str;
      square_str = ".";
      assert (ttt[i] != 2'b11);
      if (ttt[i][0])
        square_str = "O";
      else if (ttt[i][1])
        square_str = "X";
      $write("%0s%0s", square_str, (i%3 == 2) ?"\n":" | ");
    end
  endfunction

endclass


module main();
  bit clk;
  initial
  forever #5 clk = ~clk;

  tictactoe t;

  initial
  begin
    t = new();
    repeat (100000)
    begin
      assert(t.randomize());
      t.disp();
      $display("");
    end
    $display("#------------------------------------------------");
    $display("# O=%0d : X=%0d (tie=%0d)", t.O_win_cnt, t.X_win_cnt, t.tie_cnt);
    $display("#------------------------------------------------");
    $display("");
    $finish();
  end

  initial
  begin
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end
endmodule
