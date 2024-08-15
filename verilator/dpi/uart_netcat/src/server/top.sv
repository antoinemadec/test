import "DPI-C" context task dpi_uart_start_server(int idx);
import "DPI-C" function int dpi_uart_get_char(
  input int idx,
  output bit [1*8-1:0] chars
);
import "DPI-C" function void dpi_uart_send_char(
  input int idx,
  input bit [1*8-1:0] chars
);


module uart_xactor #(
    parameter int CLK_SAMPLES = 4,
    parameter int SERVER_IDX  = 0
) (
    input clk,
    input rx,
    output reg tx
);

  int fp;
  string filename;
  bit server_has_started = 0;
  initial begin
    tx = 1;
    filename = $sformatf("uart_%0d.log", SERVER_IDX);
    fp = $fopen(filename, "w");
    dpi_uart_start_server(SERVER_IDX);
    server_has_started = 1;
  end

  task automatic wait_n_cycles(int n);
    repeat (n) begin
      @(posedge clk);
    end
  endtask


  //-----------------------------------------------------------
  // tx: from client to DUT
  //-----------------------------------------------------------
  task automatic send_char(input logic [7:0] c);
    int i;

    // start bit
    tx <= 1'b0;
    wait_n_cycles(CLK_SAMPLES);

    for (i = 0; i < 8; i++) begin
      tx <= c[i];
      wait_n_cycles(CLK_SAMPLES);
    end

    // stop bit
    tx <= 1'b1;
    wait_n_cycles(CLK_SAMPLES);
  endtask

  always @(posedge clk) begin
    if (server_has_started) begin
      bit [7:0] c;
      int char_received;
      char_received = dpi_uart_get_char(SERVER_IDX, c);
      if (char_received == 1) begin
        send_char(c);
      end
    end
  end


  //-----------------------------------------------------------
  // rx: from DUT to client
  //-----------------------------------------------------------
  bit prev_rx;
  always @(posedge clk) begin
    prev_rx <= rx;
  end

  always @(posedge clk) begin
    bit [7:0] character;

    // stop: detect rx negedge
    while (!(prev_rx && !rx)) begin
      @(posedge clk);
    end

    // start
    wait_n_cycles(CLK_SAMPLES);

    // data
    for (int i = 0; i <= 7; i++) begin
      wait_n_cycles(CLK_SAMPLES >> 1);
      character[i] <= rx;
      wait_n_cycles(CLK_SAMPLES >> 1);
    end

    // print
    $fwrite(fp, "%c", character);
    dpi_uart_send_char(SERVER_IDX, character);
  end
endmodule


module top ();
  wire rx;
  wire tx;

  bit  clk = 0;
  always #1ns clk = ~clk;

  uart_xactor #(
      .CLK_SAMPLES(4),
      .SERVER_IDX (0)
  ) uart_xactor0 (
      .clk(clk),
      .rx (rx),
      .tx (tx)
  );
  uart_xactor #(
      .CLK_SAMPLES(4),
      .SERVER_IDX (1)
  ) uart_xactor1 (
      .clk(clk),
      .rx (tx),
      .tx (rx)
  );
endmodule
