class my_monitor extends uvm_monitor;

  // Virtual Interface
  virtual dut_if dut_vif;

  uvm_analysis_port #(my_transaction) item_collected_port;

  // Placeholder to capture transaction information.
  my_transaction trans_collected;

  `uvm_component_utils(my_monitor)

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif", dut_vif))
      `uvm_error("", "uvm_config_db::get failed")
  endfunction

  // run phase
  task run_phase(uvm_phase phase);
    reg rwb_d1;
    reg [7:0] addr_d1;
    begin
      forever @(posedge dut_vif.clock)
      begin
        if (!dut_vif.reset)
        begin
          if (rwb_d1)
          begin
            trans_collected = my_transaction::type_id::create("trans_collected", this);
            trans_collected.rwb   = 1;
            trans_collected.addr  = addr_d1;
            trans_collected.rdata = dut_vif.rdata;
            item_collected_port.write(trans_collected);
          end
          if (!dut_vif.rwb)
          begin
            trans_collected = my_transaction::type_id::create("trans_collected", this);
            trans_collected.rwb   = 0;
            trans_collected.addr  = dut_vif.addr;
            trans_collected.wdata = dut_vif.wdata;
            item_collected_port.write(trans_collected);
          end
          rwb_d1 = dut_vif.rwb;
          addr_d1 = dut_vif.addr;
        end
      end
    end
  endtask

endclass
