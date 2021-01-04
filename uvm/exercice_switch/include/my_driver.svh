class master_driver  extends uvm_driver #(my_transaction);
  `uvm_component_utils(master_driver)

  virtual network_if vif;
  int unsigned   bus_idx;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    bus_idx = 0;
  endfunction

  task run_phase(uvm_phase phase);
    if (!uvm_config_db #(virtual network_if)::get(this, "", $sformatf("vif_i%0d", bus_idx), vif))
      `uvm_error("", "uvm_config_db::get failed")
    else
    vif.rstn = 0;
    vif.vld <= 1'b0;
    repeat (10) @(posedge vif.clk);
    vif.rstn <= 1;
    forever
    begin
      seq_item_port.get_next_item(req);
      vif.data <= {bit'(bus_idx), req.dst, req.data};
      vif.vld  <= 1'b1;
      @(posedge vif.clk);
      while (vif.rdy !== 1) @(posedge vif.clk);
      vif.vld <= 1'b0;
      seq_item_port.item_done();
    end
  endtask

endclass


class slave_driver  extends uvm_driver #(my_transaction);
  `uvm_component_utils(slave_driver)

  virtual network_if vif;
  int unsigned   bus_idx;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    bus_idx = 0;
  endfunction

  task run_phase(uvm_phase phase);
    if (!uvm_config_db #(virtual network_if)::get(this, "", $sformatf("vif_o%0d", bus_idx), vif))
      `uvm_error("", "uvm_config_db::get failed")
    vif.rdy <= 1'b0;
    wait (vif.rstn === 1);
    forever
    begin
      vif.rdy <= $urandom;
      @(posedge vif.clk);
    end
  endtask

endclass
