class master_driver  extends uvm_driver #(my_transaction);
  `uvm_component_utils(master_driver)

  virtual dut_if vif;
  int unsigned   bus_idx;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    bus_idx = 0;
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(virtual dut_if)::get(this, "", "dut_vif", vif))
      `uvm_error("", "uvm_config_db::get failed")
  endfunction

  task run_phase(uvm_phase phase);
    vif.rst_n = 0;
    @(posedge vif.clk);
    vif.rst_n <= 1;
    forever
    begin
      seq_item_port.get_next_item(req);
      vif.in.data[bus_idx] <= req.data;
      vif.in.vld[bus_idx]  <= 1'b1;
      @(posedge vif.clk);
      while (vif.in.rdy[bus_idx] !== 1) @(posedge vif.clk);
      vif.in.vld[bus_idx] <= 1'b0;
      seq_item_port.item_done();
    end
  endtask

endclass


class slave_driver  extends uvm_driver #(my_transaction);
  `uvm_component_utils(slave_driver)

  virtual dut_if vif;
  int unsigned   bus_idx;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    bus_idx = 0;
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(virtual dut_if)::get(this, "", "dut_vif", vif))
      `uvm_error("", "uvm_config_db::get failed")
  endfunction

  task run_phase(uvm_phase phase);
    wait (vif.rst_n === 1);
    forever
    begin
      vif.out.rdy[bus_idx] <= $urandom;
      @(posedge vif.clk);
    end
  endtask

endclass
