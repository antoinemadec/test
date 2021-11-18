module top();

  import "DPI-C" context task startServer();
  import "DPI-C" context task acceptNewSocket();
  export "DPI-C" task write_dut;
  export "DPI-C" task read_dut;


  bit [31:0] arr[1<<8];

  task read_dut(input bit [7:0] add, output bit [31:0] rdata);
    rdata = arr[add];
    $display("SV: %0t ns    0x%x <- [0x%x]", $time, rdata, add);
  endtask

  task write_dut(input bit [7:0] add, input bit [31:0] wdata);
    arr[add] = wdata;
    $display("SV: %0t ns    0x%x -> [0x%x]", $time, wdata, add);
  endtask


  // HW/SW server communication
  initial begin
    bit server_has_started;
    server_has_started = 0;
    forever begin
      #1000;
      if (server_has_started == 0) begin
        startServer();
        server_has_started = 1;
      end
      else begin
        acceptNewSocket();
      end
    end
  end

endmodule
