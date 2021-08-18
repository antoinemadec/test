class ttt;
  typedef enum {X, O, NONE} ttt_value_t;
  
  rand ttt_value_t tab[3][3];

  // compute variables
  rand int X_cnt;
  rand int O_cnt;
  rand bit X_has_won;
  rand bit O_has_won;

  constraint c {
    X_cnt == count_in_tab(tab, X);
    O_cnt == count_in_tab(tab, O);
    X_cnt >= O_cnt - (X_has_won ? 0:1);
    O_cnt >= X_cnt - (O_has_won ? 0:1);

    X_has_won == has_won_in_tab(tab, X);
    O_has_won == has_won_in_tab(tab, O);
    !X_has_won || !O_has_won;
  }

  function int count_in_tab(ttt_value_t tab[3][3], ttt_value_t val);
    count_in_tab = 0;
    foreach(tab[i])
      foreach(tab[i][j])
        if (tab[i][j] == val)
          count_in_tab ++;
    return count_in_tab;
  endfunction: count_in_tab

  function bit has_won_in_tab(ttt_value_t tab[3][3], ttt_value_t val);
    int cnt[7] = '{default: 0};
    has_won_in_tab = 0;
    for (int i = 0; i < 3; i++) begin
      for (int j = 0; j < 3; j++) begin
        if (tab[i][j] == val) begin
          cnt[i] ++;
          cnt[j+3] ++;
          if (i == j) begin
            cnt[6] ++;
          end
        end
      end
    end
    foreach (cnt[i]) begin
      if (cnt[i] == 3) begin
        has_won_in_tab = 1;
      end
    end
    return has_won_in_tab;
  endfunction: has_won_in_tab

  function string enum_to_char(ttt_value_t val);
    enum_to_char = ".";
    if (val != NONE) begin
      enum_to_char = val.name();
    end
    return enum_to_char;
  endfunction: enum_to_char

  function void print();
    foreach(tab[i])
      $display("%s %s %s",
        enum_to_char(tab[i][0]), enum_to_char(tab[i][1]), enum_to_char(tab[i][2]));
  endfunction: print

endclass : ttt


module main ();
  initial begin
    ttt h;
    h = new();
    repeat (100) begin
      assert(randomize(h));
      $display("-----------------------------------------------");
      $display("cnt(X,O)=(%0d,%0d)", h.X_cnt, h.O_cnt);
      $display("score(X,O)=(%0d,%0d)\n", h.X_has_won, h.O_has_won);
      h.print();
    end
  end
endmodule
