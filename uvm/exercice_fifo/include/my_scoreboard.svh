`uvm_analysis_imp_decl(_rx)
`uvm_analysis_imp_decl(_tx)

class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  uvm_analysis_imp_rx#(my_transaction, my_scoreboard) item_collected_export_rx;
  uvm_analysis_imp_tx#(my_transaction, my_scoreboard) item_collected_export_tx;

  int q[$];

  function new(string name, uvm_component parent);
    super.new(name,parent);
    item_collected_export_rx = new("item_collected_export_rx", this);
    item_collected_export_tx = new("item_collected_export_tx", this);
  endfunction

  function write_rx(my_transaction pkt);
    q.push_back(pkt.data);
  endfunction

  function write_tx(my_transaction pkt);
    int exp;
    exp = q.pop_front();
    if (exp != pkt.data)
      `uvm_fatal("SCOREBOARD", $sformatf("exp=0x%x, got data=0x%x", exp, pkt.data))
  endfunction
endclass
