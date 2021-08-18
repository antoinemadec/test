class ttt;
  rand int arr[9][9];

  constraint c {
    foreach (arr[i, j]) {
      // numbers between 1 and 9
      arr[i][j] inside {[1:9]};

      // cannot have the same number in a row
      foreach (arr[ , l]) {
        if (j != l) {
          arr[i][j] != arr[i][l];
        }
      }

      // cannot have the same number in a column
      foreach (arr[k,  ]) {
        if (i != k) {
          arr[i][j] != arr[k][j];
        }
      }

      // cannot have the same number in a square
      foreach (arr[k, l]) {
        if ((i/3 == k/3) && (j/3 == l/3) && (i != k) && (j != l)) {
          arr[i][j] != arr[k][l];
        }
      }
    }
  }

  function void print();
    for (int i = 0; i < 9; i++) begin
      if ((i%3) == 0) begin
        $write("----------------------\n");
      end
      for (int j = 0; j < 9; j++) begin
        if ((j%3) == 0) begin
          $write("|");
        end
        $write(" %0d", arr[i][j]);
      end
      $write("|\n");
    end
    $write("----------------------\n");
  endfunction: print

endclass : ttt


module main ();
  initial begin
    ttt h;
    h = new();
    repeat (100) begin
      assert(randomize(h));
      $display("===============================================");
      h.print();
    end
  end
endmodule
