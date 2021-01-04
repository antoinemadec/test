package my_testbench_pkg;
  import uvm_pkg::*;
  `include "my_sequence.svh"
  `include "my_monitor.svh"
  `include "my_driver.svh"
  `include "my_scoreboard.svh"

  class master_agent extends uvm_agent;
    `uvm_component_utils(master_agent)

    my_monitor monitor;
    master_driver driver;
    uvm_sequencer#(my_transaction) sequencer;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      monitor   = my_monitor::type_id::create("monitor", this);
      driver    = master_driver::type_id::create("driver", this);
      sequencer = uvm_sequencer#(my_transaction)::type_id::create("sequencer", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
  endclass

  class slave_agent extends uvm_agent;
    `uvm_component_utils(slave_agent)

    my_monitor#(1) monitor;
    slave_driver driver;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      monitor   = my_monitor#(1)::type_id::create("monitor", this);
      driver    = slave_driver::type_id::create("driver", this);
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
      m_agent.monitor.item_collected_port.connect(scoreboard.item_collected_export_rx);
      s_agent.monitor.item_collected_port.connect(scoreboard.item_collected_export_tx);
    endfunction
  endclass

  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    my_sequence seq;
    my_env env;

    function new(string name, uvm_component parent);
      super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      env = my_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = my_sequence::type_id::create("seq");
      assert(seq.randomize());
      `uvm_info("START", $sformatf("xaction_nb=%0d", seq.xaction_nb), UVM_MEDIUM)
      seq.start(env.m_agent.sequencer);
      wait (env.s_agent.monitor.xaction_nb == seq.xaction_nb);
      phase.drop_objection(this);
    endtask
  endclass
endpackage
