`uvm_analysis_imp_decl(_rx)
`uvm_analysis_imp_decl(_tx)

class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  uvm_analysis_imp_rx#(my_transaction, my_scoreboard) item_collected_export_rx;
  uvm_analysis_imp_tx#(my_transaction, my_scoreboard) item_collected_export_tx;

  my_transaction exp_pkt, prev_pkt, pkt_q[$];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export_rx = new("item_collected_export_rx", this);
    item_collected_export_tx = new("item_collected_export_tx", this);
    prev_pkt                 = new();
    prev_pkt.data            = 0;
    exp_pkt = new();
  endfunction

  function write_rx(my_transaction pkt);
    pkt_q.push_back(pkt);
  endfunction

  function write_tx(my_transaction pkt);
    my_transaction cur_pkt;
    if (pkt_q.size() != 0)
    begin
      cur_pkt         = pkt_q.pop_front();
      exp_pkt.data    = cur_pkt.data + prev_pkt.data;
      prev_pkt.data   = cur_pkt.data;
    end
  endfunction
endclass
