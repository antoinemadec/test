class my_monitor #(parameter PASSIVE=0) extends uvm_monitor;
  `uvm_component_param_utils(my_monitor#(PASSIVE))

  uvm_analysis_port #(my_transaction) item_collected_port;
  virtual dut_if vif;
  int unsigned xaction_nb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
    xaction_nb = 0;
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif", vif))
      `uvm_error("", "uvm_config_db::get failed")
  endfunction

  task run_phase(uvm_phase phase);
    my_transaction rx, tx, toto;
    forever @(posedge vif.clk)
      if (vif.rst_n)
        if (PASSIVE && vif.out_rdy && vif.out_vld)
        begin
          tx = my_transaction::type_id::create("tx", this);
          tx.data = vif.out_data;
          item_collected_port.write(tx);
          xaction_nb ++;
        end
        else if (!PASSIVE && vif.in_rdy && vif.in_vld)
        begin
          rx = my_transaction::type_id::create("rx", this);
          rx.data = vif.in_data;
          item_collected_port.write(rx);
          rx.print();
          xaction_nb ++;
        end
  endtask

endclass
