module cpu #(
    parameter bit [63:0] SEED
) (
    input bit clk,
    output bit data_vld,
    output bit [63:0] data
);

  function automatic bit [63:0] xorshift64star(input bit [63:0] x, input bit [31:0] iterations = 1);
    repeat (iterations) begin
      x = x ^ (x >> 12);
      x = x ^ (x << 25);
      x = x ^ (x >> 27);
      x = x * 64'h5821657736338717;
    end
    return x;
  endfunction

  task static wait_n_cycles(input bit [31:0] n);
    repeat (n) begin
      @(posedge clk);
    end
  endtask

  bit [63:0] x = SEED;
  always_ff @(posedge clk) begin
    data_vld <= 0;
    x <= xorshift64star(x, 1000000);
    wait_n_cycles(int'(x[15:0]));
    data_vld <= 1;
    data <= x;
  end

endmodule
