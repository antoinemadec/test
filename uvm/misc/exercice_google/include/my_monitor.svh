class my_monitor #(parameter PASSIVE=0) extends uvm_monitor;
  `uvm_component_param_utils(my_monitor#(PASSIVE))

  uvm_analysis_port #(my_transaction) item_collected_port;
  virtual dut_if vif;
  int unsigned xaction_nb;
  int unsigned bus_idx;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
    xaction_nb = 0;
    bus_idx    = 0;
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif", vif))
      `uvm_error("", "uvm_config_db::get failed")
  endfunction

  task run_phase(uvm_phase phase);
    my_transaction rx, tx;
    integer fd;
    fd = $fopen($sformatf("monitor_%0s_%0d.txt", PASSIVE ? "out":"in", bus_idx));
    forever @(posedge vif.clk)
      if (vif.rst_n)
        if (PASSIVE && vif.out.rdy[bus_idx] && vif.out.vld[bus_idx])
        begin
          tx = my_transaction::type_id::create("tx", this);
          tx.data = vif.out.data[bus_idx];
          $fwrite(fd, "0x%x\n", tx.data);
          item_collected_port.write(tx);
          xaction_nb ++;
        end
        else if (!PASSIVE && vif.in.rdy[bus_idx] && vif.in.vld[bus_idx])
        begin
          rx = my_transaction::type_id::create("rx", this);
          rx.data = vif.in.data[bus_idx];
          $fwrite(fd, "0x%x\n", rx.data);
          item_collected_port.write(rx);
          xaction_nb ++;
        end
  endtask

endclass
