`uvm_analysis_imp_decl(_rx0)
`uvm_analysis_imp_decl(_rx1)
`uvm_analysis_imp_decl(_tx0)
`uvm_analysis_imp_decl(_tx1)

class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  uvm_analysis_imp_rx0#(my_transaction, my_scoreboard) item_collected_export_rx0;
  uvm_analysis_imp_rx1#(my_transaction, my_scoreboard) item_collected_export_rx1;
  uvm_analysis_imp_tx0#(my_transaction, my_scoreboard) item_collected_export_tx0;
  uvm_analysis_imp_tx1#(my_transaction, my_scoreboard) item_collected_export_tx1;

  int q[2][2][$];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export_rx0 = new("item_collected_export_rx0", this);
    item_collected_export_rx1 = new("item_collected_export_rx1", this);
    item_collected_export_tx0 = new("item_collected_export_tx0", this);
    item_collected_export_tx1 = new("item_collected_export_tx1", this);
  endfunction

  function write_rx0(my_transaction pkt);
    q[pkt.src][pkt.dst].push_back(pkt.data);
  endfunction
  function write_rx1(my_transaction pkt);
    q[pkt.src][pkt.dst].push_back(pkt.data);
  endfunction

  function write_tx0(my_transaction pkt);
    int expected_data;
    expected_data = q[pkt.src][pkt.dst].pop_front();
    if (expected_data != pkt.data)
      `uvm_fatal("SCOREBOARD", $sformatf("exp_data=0x%x ; data=0x%x",
        expected_data, pkt.data))
  endfunction
  function write_tx1(my_transaction pkt);
    int expected_data;
    expected_data = q[pkt.src][pkt.dst].pop_front();
    if (expected_data != pkt.data)
      `uvm_fatal("SCOREBOARD", $sformatf("exp_data=0x%x ; data=0x%x",
        expected_data, pkt.data))
  endfunction

endclass
