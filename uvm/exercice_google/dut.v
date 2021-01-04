interface rdy_vld_if
  #(
    int N  = 1,
    type T = bit
  )
  (
    input clk
    );
  logic rdy[N];
  logic vld[N];
  T     data[N];
endinterface

interface dut_if(input clk);
  logic rst_n;
  rdy_vld_if#(.N(4), .T(bit [31:0])) in(clk);
  rdy_vld_if#(.N(1), .T(bit [31:0])) out(clk);
endinterface



// Takes 4 rdy/vld inputs and put then into 4 dinstinct FIFO.
// Output randomly pop one of the populated fifo.
module dut(dut_if dif);

  bit [31:0] in_data_q[4][$];
  int current_in_idx;
  wor in_data_q_not_empty;
  for (genvar i=0; i<4; i++)
    assign in_data_q_not_empty = (in_data_q[i].size() != 0);

  always @(posedge dif.clk)
  begin
    bit get_new_output_data;
    if (!dif.rst_n)
    begin
      get_new_output_data = 1;
      current_in_idx      = -1;
      dif.out.vld[0]      <= 1'b0;
      for(int i=0; i<4; i++)
        dif.in.rdy[i] <= 1'b0;
    end
    else
    begin
      for(int i=0; i<4; i++)
        dif.in.rdy[i] <= $urandom;

      // in
      for(int i=0; i<4; i++)
      begin
        if (dif.in.rdy[i] && dif.in.vld[i])
          in_data_q[i].push_back(dif.in.data[i]);
      end

      // out
      if (dif.out.rdy[0] && dif.out.vld[0])
      begin
        void'(in_data_q[current_in_idx].pop_front());
        get_new_output_data = 1;
      end
      if (in_data_q_not_empty)
      begin
        if (get_new_output_data)
        begin
          int valid_in_idx[$];
          valid_in_idx = {};
          for (int i=0; i<4; i++)
            if (in_data_q[i].size() != 0)
              valid_in_idx.push_back(i);
          valid_in_idx.shuffle();
          current_in_idx      = valid_in_idx[0];
          get_new_output_data = 0;
        end
      dif.out.vld[0]  <= 1'b1;
      dif.out.data[0] <= in_data_q[current_in_idx][0];
      end
    end
  end
endmodule
