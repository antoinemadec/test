class my_monitor#(parameter PASSIVE=0) extends uvm_monitor;
  `uvm_component_param_utils(my_monitor#(PASSIVE))

  uvm_analysis_port #(my_transaction) item_collected_port;
  int xaction_nb;
  virtual fifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    xaction_nb = 0;
    item_collected_port = new ("item_collected_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    my_transaction tx;
    tx = my_transaction::type_id::create("tx", this);
    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_error("","could not get vif")
    forever
    begin
      @(posedge vif.clk);
      if (vif.rstn)
      begin
        if (PASSIVE && vif.out_rdy && vif.out_vld)
        begin
          tx.data = vif.out_data;
          item_collected_port.write(tx);
          `uvm_info("POP", $sformatf("id=%0d", xaction_nb), UVM_MEDIUM)
          xaction_nb++;
        end
        else if (!PASSIVE && vif.in_rdy && vif.in_vld)
        begin
          tx.data = vif.in_data;
          item_collected_port.write(tx);
          `uvm_info("PUSH", $sformatf("id=%0d", xaction_nb), UVM_MEDIUM)
          xaction_nb++;
        end
      end
    end
  endtask

endclass
