class queens;
  localparam N = 8;

  rand bit arr[N][N];

  constraint c {
    // N queens
    arr.sum(item1d) with (item1d.sum(item2d) with (int'(item2d))) == N;

    foreach (arr[i, j]) {
      if (arr[i][j] == 1) {
        // only one 1 in a col
        foreach (arr[ , l]) {
          if (j != l) {
            arr[i][l] == 0;
          }
        }

        // only one 1 in a row
        foreach (arr[k, ]) {
          if (i != k) {
            arr[k][j] == 0;
          }
        }

        // only on 1 in a diagonal
        foreach (arr[k,l]) {
          if ((((i-k) == (j-l)) || ((i-k) == (l-j))) && i!=k && j!=l) {
            arr[k][l] == 0;
          }
        }
      }
    }
  }


  function void print();
    for (int j = 0; j < N; j++) begin
      for (int i = 0; i < N; i++) begin
        $write(" %c", arr[i][j] ? "Q" : ".");
      end
      $write("|\n");
    end
  endfunction: print

endclass : queens


module main ();
  initial begin
    queens h;
    h = new();
    repeat (1) begin
      assert(randomize(h));
      $display("===============================================");
      h.print();
    end
  end
endmodule
