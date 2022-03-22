package my_testbench_pkg;
  import uvm_pkg::*;
  `include "my_sequence.svh"
  `include "my_driver.svh"
  `include "my_monitor.svh"
  `include "my_monitor_extended.svh"
  `include "my_scoreboard.svh"

  class master_agent extends uvm_agent;
    `uvm_component_utils(master_agent)

    my_monitor#(0)                 m_monitor;
    master_driver                  m_driver;
    uvm_sequencer#(my_transaction) sequencer;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      m_monitor = my_monitor#(0)::type_id::create("m_monitor", this);
      m_driver  = master_driver::type_id::create("m_driver", this);
      sequencer = uvm_sequencer#(my_transaction)::type_id::create("sequencer", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      m_driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
  endclass

  class slave_agent extends uvm_agent;
    `uvm_component_utils(slave_agent)

    my_monitor#(1) s_monitor;
    slave_driver   s_driver;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      s_monitor = my_monitor#(1)::type_id::create("s_monitor", this);
      s_driver  = slave_driver::type_id::create("s_driver", this);
    endfunction
  endclass

  class my_env extends uvm_env;
    `uvm_component_utils(my_env)

    master_agent  m_agent;
    slave_agent   s_agent;
    my_scoreboard scoreboard;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      m_agent    = master_agent::type_id::create("m_agent", this);
      s_agent    = slave_agent::type_id::create("s_agent", this);
      scoreboard = my_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      m_agent.m_monitor.item_collected_port.connect(scoreboard.item_collected_export_rx);
      s_agent.s_monitor.item_collected_port.connect(scoreboard.item_collected_export_tx);
    endfunction
  endclass

  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    my_env env;
    master_sequence seq[2];


    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      my_monitor#(0)::type_id::set_type_override(my_monitor_extended#(0)::get_type(), 1);
      my_monitor#(1)::type_id::set_type_override(my_monitor_extended#(1)::get_type(), 1);
      env = my_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
      int i;
      phase.raise_objection(this);
      `uvm_info("", "start test", UVM_MEDIUM)
      `uvm_info("", {"full name is",env.m_agent.sequencer.get_full_name()}, UVM_MEDIUM)
      for (i=0; i<2; i++)
        seq[i] = master_sequence::type_id::create($sformatf("seq%0d", i),,env.m_agent.sequencer.get_full_name());
      my_transaction::type_id::set_inst_override(my_transaction_deadbeef::get_type(), {env.m_agent.sequencer.get_full_name(),".seq1.req"});
      for (i=0; i<2; i++)
      begin
        automatic int auto_i = i;
        fork
          seq[auto_i].start(env.m_agent.sequencer);
        join_none
      end
      wait fork;
      $display("rx count=%0d", env.m_agent.m_monitor.xaction_nb);
      phase.drop_objection(this);
    endtask

  endclass
endpackage
