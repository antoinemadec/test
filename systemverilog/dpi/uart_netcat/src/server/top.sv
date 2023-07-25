import "DPI-C" context task uart_start_server(int idx);
import "DPI-C" function int  uart_get_char(input int idx, output bit[1*8-1:0] chars);

module uart_xactor #(parameter int server_idx) (
  input rx,
  output tx
);

  // HW/SW server communication
  initial begin
    bit server_has_started;
    server_has_started = 0;
    forever begin
      #1000;
      if (server_has_started == 0) begin
        uart_start_server(server_idx);
        server_has_started = 1;
      end
      else begin
        bit [7:0] c;
        int char_received;
        char_received = uart_get_char(server_idx, c);
        if (char_received) begin
          $display("%s", c);
        end
      end
    end
  end

endmodule


module top ();
  wire rx;
  wire tx;

  uart_xactor #(0) uart_xactor0();
  // uart_xactor #(1) uart_xactor1();
endmodule
