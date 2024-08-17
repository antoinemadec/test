import "DPI-C" function void dpi_cpu_server_start(int idx);
import "DPI-C" function int dpi_cpu_server_get_data(
  int idx,
  output bit [63:0] data
);

module noc_dpi_server #(
    parameter int CPU_NB = 4
) (
    input bit clk
);

  bit  data_rdy[CPU_NB];
  bit  data_vld[CPU_NB];
  bit [63:0] data[CPU_NB];

  noc #(
      .CPU_NB(CPU_NB)
  ) i_noc (
      .clk     (clk),
      .data_rdy(data_rdy),
      .data_vld(data_vld),
      .data    (data)
  );

  for (genvar cpu_idx = 0; cpu_idx < CPU_NB; cpu_idx++) begin : gen_cpu
    bit cpu_data_rdy;
    bit cpu_data_vld;
    bit [63:0] cpu_data;

    assign cpu_data_rdy = data_rdy[cpu_idx];
    assign data_vld[cpu_idx] = cpu_data_vld;
    assign data[cpu_idx] = cpu_data;

    bit server_has_started = 0;
    initial begin
      dpi_cpu_server_start(cpu_idx);
      server_has_started = 1;
    end

    always @(posedge clk) begin
      bit [63:0] data_dpi;
      if (server_has_started && (!cpu_data_vld || cpu_data_rdy)) begin
        bit data_vld_dpi;
        data_vld_dpi = dpi_cpu_server_get_data(cpu_idx, data_dpi) [0];
        cpu_data_vld <= data_vld_dpi;
        cpu_data <= data_dpi;
      end
    end
  end

endmodule

