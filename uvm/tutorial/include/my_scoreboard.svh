class my_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(my_scoreboard)
  uvm_analysis_imp#(my_transaction, my_scoreboard) item_collected_export;
  reg[7:0] mem_array[*];

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
  endfunction

  // write
  function void write(my_transaction pkt);
    `uvm_info("SCOREBOARD", pkt.convert2string(), UVM_MEDIUM)
    if (pkt.rwb)
      assert (pkt.rdata === mem_array[pkt.addr]) else
        `uvm_fatal("COMPARE FAIL", $sformatf("read: addr=0x%x; rdata=0x%x; expected=0x%x", pkt.addr, pkt.rdata, mem_array[pkt.addr]))
    else
      mem_array[pkt.addr] = pkt.wdata;
  endfunction

endclass
