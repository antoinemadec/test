class my_monitor #(parameter PASSIVE=0) extends uvm_monitor;
  `uvm_component_param_utils(my_monitor#(PASSIVE))

  uvm_analysis_port #(my_transaction) item_collected_port;
  virtual network_if vif;
  int unsigned xaction_nb;
  int unsigned bus_idx;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
    xaction_nb = 0;
    bus_idx    = 0;
  endfunction

  task run_phase(uvm_phase phase);
    my_transaction tx;
    integer fd;
    fd = $fopen($sformatf("monitor_%0s_%0d.txt", PASSIVE ? "out":"in", bus_idx));
    if (PASSIVE)
    begin
      if (!uvm_config_db #(virtual network_if)::get(this, "", $sformatf("vif_o%0d", bus_idx), vif))
        `uvm_error("", "uvm_config_db::get failed")
    end
    else
    begin
      if (!uvm_config_db #(virtual network_if)::get(this, "", $sformatf("vif_i%0d", bus_idx), vif))
        `uvm_error("", "uvm_config_db::get failed")
    end
    forever @(posedge vif.clk)
    if (vif.rstn)
    begin
      tx = my_transaction::type_id::create("tx", this);
      if (vif.rdy && vif.vld)
      begin
        tx.data = vif.data[31:0];
        tx.src  = vif.get_src();
        tx.dst  = vif.get_dst();
        $fwrite(fd, "0x%x dst=%0d\n", tx.data, tx.dst);
        item_collected_port.write(tx);
        xaction_nb ++;
      end
    end
  endtask

endclass
