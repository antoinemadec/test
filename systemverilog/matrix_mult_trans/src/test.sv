module test();

  typedef int m4x1_t [4][1];
  typedef int m4x4_t [4][4];
  typedef int m16x16_t [16][16];

  typedef int m3x1_t [3][1];
  typedef int m1x3_t [1][3];
  typedef int m3x3_t [3][3];

  m4x4_t m4x4;
  m4x1_t m4x1;
  m3x1_t m3x1;
  m3x3_t m3x3;

  function void print(int m[][], int raw, int col);
    $display("-- print:");
    for (int i=0; i<raw; i++)
    begin
      for (int j=0; j<col; j++)
        $write("%4d ", m[i][j]);
      $write("\n");
    end
  endfunction

  function m4x1_t mult_4x4x1(int m[4][4], int v[4][1]);
    int sum;
    for (int i=0; i<4; i++)
    begin
      sum = 0;
      for (int j=0; j<4; j++)
        sum += m[i][j] * v[j][0];
      mult_4x4x1[i][0] = sum;
    end
  endfunction

  function m4x4_t mult_4x4x4(int m0[4][4], int m1[4][4]);
    m4x1_t v;
    for (int i=0; i<4; i++)
    begin
      v = mult_4x4x1(m0,'{'{m1[0][i]},'{m1[1][i]},'{m1[2][i]},'{m1[3][i]}});
      mult_4x4x4[0][i] = v[0][0];
      mult_4x4x4[1][i] = v[1][0];
      mult_4x4x4[2][i] = v[2][0];
      mult_4x4x4[3][i] = v[3][0];
    end
  endfunction

  function m1x3_t trans_3x1(m3x1_t m);
    for (int i=0; i<3; i++)
      trans_3x1[0][i] = m[i][0];
  endfunction

  function m3x3_t trans_3x3(m3x3_t m);
    m1x3_t v;
    for (int i=0; i<3; i++)
    begin
      v = trans_3x1('{'{m[0][i]},'{m[1][i]},'{m[2][i]}});
      trans_3x3[i][0] = v[0][0];
      trans_3x3[i][1] = v[0][1];
      trans_3x3[i][2] = v[0][2];
    end
  endfunction

  initial
  begin
    #10;
    m4x4 = '{'{0,1,2,3},'{4,5,6,7},'{8,9,10,11},'{12,13,14,15}};
    m4x1 = '{'{0},'{1},'{2},'{3}};
    m3x1 = '{'{0},'{1},'{2}};
    m3x3 = '{'{0,1,2},'{3,4,5},'{6,7,8}};
    print(m4x4, 4, 4);
    print(mult_4x4x1(m4x4, m4x1), 4, 1);
    print(mult_4x4x4(m4x4, m4x4), 4, 4);
    print(trans_3x1(m3x1), 1, 3);
    print(m3x3, 3, 3);
    print(trans_3x3(m3x3), 3, 3);
    #10;
    $finish;
  end

endmodule
