`uvm_analysis_imp_decl(_rx0)
`uvm_analysis_imp_decl(_rx1)
`uvm_analysis_imp_decl(_rx2)
`uvm_analysis_imp_decl(_rx3)
`uvm_analysis_imp_decl(_tx0)

class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  uvm_analysis_imp_rx0#(my_transaction, my_scoreboard) item_collected_export_rx0;
  uvm_analysis_imp_rx1#(my_transaction, my_scoreboard) item_collected_export_rx1;
  uvm_analysis_imp_rx2#(my_transaction, my_scoreboard) item_collected_export_rx2;
  uvm_analysis_imp_rx3#(my_transaction, my_scoreboard) item_collected_export_rx3;
  uvm_analysis_imp_tx0#(my_transaction, my_scoreboard) item_collected_export_tx0;

  typedef my_transaction in_fifo_t[$];
  typedef in_fifo_t in_fifos_t[4];
  typedef struct {
    in_fifos_t in_fifos;
    string     pop[$];
  } branch_s;
  branch_s branches[$];
  string possible_scenarios[int];
  static const in_fifos_t empty_in_fifos = '{{},{},{},{}};                  // simplifies notation
  static const branch_s empty_branch = '{in_fifos: empty_in_fifos, pop:{}}; // simplifies notation

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export_rx0 = new("item_collected_export_rx0", this);
    item_collected_export_rx1 = new("item_collected_export_rx1", this);
    item_collected_export_rx2 = new("item_collected_export_rx2", this);
    item_collected_export_rx3 = new("item_collected_export_rx3", this);
    item_collected_export_tx0 = new("item_collected_export_tx0", this);
    branches                  = {empty_branch};
  endfunction

  function write_rx0(my_transaction pkt);
    foreach (branches[b])
      branches[b].in_fifos[0].push_back(pkt);
  endfunction
  function write_rx1(my_transaction pkt);
    foreach (branches[b])
      branches[b].in_fifos[1].push_back(pkt);
  endfunction
  function write_rx2(my_transaction pkt);
    foreach (branches[b])
      branches[b].in_fifos[2].push_back(pkt);
  endfunction
  function write_rx3(my_transaction pkt);
    foreach (branches[b])
      branches[b].in_fifos[3].push_back(pkt);
  endfunction

  function write_tx0(my_transaction pkt);
    int match_per_branch, branch_nb;
    branch_nb = branches.size();
    foreach (branches[b])
    begin
      branch_s original_branch;
      original_branch  = branches[b];
      match_per_branch = 0;
      for (int in=0; in<4; in++)
        if (original_branch.in_fifos[in].size())
        begin
          if (original_branch.in_fifos[in][0].data == pkt.data)
          begin
            // modify curent branch for 1st input match,
            // add new branches for extra input matches
            if (match_per_branch == 0)
            begin
              void'(branches[b].in_fifos[in].pop_front());
              branches[b].pop.push_back($sformatf("%0d: 0x%x", in, pkt.data));
            end
            else
            begin
              branch_s new_branch;
              new_branch = original_branch;
              void'(new_branch.in_fifos[in].pop_front());
              new_branch.pop.push_back($sformatf("%0d: 0x%x", in, pkt.data));
              branches.push_back(new_branch);
            end
            match_per_branch ++;
          end
        end
      if (match_per_branch == 0)
      begin
        branches[b] = empty_branch; // mark the branch as "to be removed"
        branch_nb--;
      end
    end
    `uvm_info("", $sformatf("branch_nb=%0d", branch_nb), UVM_MEDIUM)
    branches = branches.find() with (item != empty_branch); // remove branches
    if (branch_nb == 0)
      `uvm_fatal("SCOREBOARD", $sformatf("unexpected output data 0x%x", pkt.data))
    if (branch_nb > 2048)
      `uvm_fatal("SCOREBOARD", $sformatf("stop simulation because branch nb = %0d is too big", branch_nb))
  endfunction
endclass
