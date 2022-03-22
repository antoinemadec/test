class master_driver extends uvm_driver#(my_transaction);
  `uvm_component_utils(master_driver)
  virtual fifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
   if (!uvm_config_db#(virtual fifo_if)::get(this,"", "vif", vif))
     `uvm_error("","could not get vif")
    vif.rstn = 0;
    vif.in_vld = 0;
    repeat (10) @(posedge vif.clk);
    vif.rstn <= 1;
    forever
    begin
      seq_item_port.get_next_item(req);
      vif.in_data <= req.data;
      vif.in_vld <= 1;
      @(posedge vif.clk);
      while (!vif.in_rdy)
        @(posedge vif.clk);
      vif.in_data <= 32'hx;
      vif.in_vld <= 0;
      seq_item_port.item_done();
    end
  endtask

endclass


class slave_driver extends uvm_driver#(my_transaction);
  `uvm_component_utils(slave_driver)
  virtual fifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
   if (!uvm_config_db#(virtual fifo_if)::get(this,"", "vif", vif))
     `uvm_error("","could not get vif")
    vif.rstn = 0;
    vif.out_rdy = 0;
    wait(vif.rstn);
    forever @(posedge vif.clk)
    begin
      vif.out_rdy <= $urandom;
    end
  endtask

endclass
