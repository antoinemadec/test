package my_testbench_pkg;
  import uvm_pkg::*;
  `include "my_sequence.svh"
  `include "my_driver.svh"
  `include "my_monitor.svh"
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

    master_agent  m_agent[2];
    slave_agent   s_agent[2];
    my_scoreboard scoreboard;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      m_agent[0] = master_agent::type_id::create("m_agent_0", this);
      m_agent[1] = master_agent::type_id::create("m_agent_1", this);
      s_agent[0] = slave_agent::type_id::create("s_agent_0", this);
      s_agent[1] = slave_agent::type_id::create("s_agent_1", this);
      scoreboard = my_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      m_agent[0].m_monitor.item_collected_port.connect(scoreboard.item_collected_export_rx0);
      m_agent[1].m_monitor.item_collected_port.connect(scoreboard.item_collected_export_rx1);
      s_agent[0].s_monitor.item_collected_port.connect(scoreboard.item_collected_export_tx0);
      s_agent[1].s_monitor.item_collected_port.connect(scoreboard.item_collected_export_tx1);
      // TODO find better way to do it
      m_agent[0].m_driver.bus_idx  = 0;
      m_agent[1].m_driver.bus_idx  = 1;
      m_agent[0].m_monitor.bus_idx = 0;
      m_agent[1].m_monitor.bus_idx = 1;
      s_agent[0].s_driver.bus_idx  = 0;
      s_agent[1].s_driver.bus_idx  = 1;
      s_agent[0].s_monitor.bus_idx = 0;
      s_agent[1].s_monitor.bus_idx = 1;
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
      env = my_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("", "start test", UVM_MEDIUM)
      master_sequence::transaction_nb = 256;
      seq[0] = master_sequence::type_id::create("seq0");
      seq[1] = master_sequence::type_id::create("seq1");
      for (int i=0; i<2; i++)
      begin
        assert(seq[i].randomize());
        seq[i].print();
      end
      fork
        seq[0].start(env.m_agent[0].sequencer);
        seq[1].start(env.m_agent[1].sequencer);
      join
      wait((env.s_agent[0].s_monitor.xaction_nb + env.s_agent[1].s_monitor.xaction_nb)== 2*master_sequence::transaction_nb);
      phase.drop_objection(this);
    endtask

  endclass
endpackage
