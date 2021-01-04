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

    master_agent  m_agent[4];
    slave_agent   s_agent;
    my_scoreboard scoreboard;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      m_agent[0]                   = master_agent::type_id::create("m_agent_0", this);
      m_agent[1]                   = master_agent::type_id::create("m_agent_1", this);
      m_agent[2]                   = master_agent::type_id::create("m_agent_2", this);
      m_agent[3]                   = master_agent::type_id::create("m_agent_3", this);
      s_agent                      = slave_agent::type_id::create("s_agent", this);
      scoreboard                   = my_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      m_agent[0].m_monitor.item_collected_port.connect(scoreboard.item_collected_export_rx0);
      m_agent[1].m_monitor.item_collected_port.connect(scoreboard.item_collected_export_rx1);
      m_agent[2].m_monitor.item_collected_port.connect(scoreboard.item_collected_export_rx2);
      m_agent[3].m_monitor.item_collected_port.connect(scoreboard.item_collected_export_rx3);
      s_agent.s_monitor.item_collected_port.connect(scoreboard.item_collected_export_tx0);
      // TODO: find a more UVM-ic way to do it
      m_agent[0].m_driver.bus_idx           = 0;
      m_agent[1].m_driver.bus_idx           = 1;
      m_agent[2].m_driver.bus_idx           = 2;
      m_agent[3].m_driver.bus_idx           = 3;
      m_agent[0].m_monitor.bus_idx = 0;
      m_agent[1].m_monitor.bus_idx = 1;
      m_agent[2].m_monitor.bus_idx = 2;
      m_agent[3].m_monitor.bus_idx = 3;
    endfunction
  endclass

  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    my_env env;
    master_sequence seq[4];

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
      seq[2] = master_sequence::type_id::create("seq2");
      seq[3] = master_sequence::type_id::create("seq3");
      for (int i=0; i<4; i++)
      begin
        assert(seq[i].randomize());
        seq[i].print();
      end
      fork
        seq[0].start(env.m_agent[0].sequencer);
        seq[1].start(env.m_agent[1].sequencer);
        seq[2].start(env.m_agent[2].sequencer);
        seq[3].start(env.m_agent[3].sequencer);
      join
      wait(env.s_agent.s_monitor.xaction_nb == 4*master_sequence::transaction_nb);
      `uvm_info("", $sformatf("remaining branches = %0d", env.scoreboard.branches.size()), UVM_MEDIUM)
      //foreach (env.scoreboard.branches[b])
      //begin
      //  integer fd;
      //  fd = $fopen($sformatf("branch_%0d.txt", b));
      //  foreach (env.scoreboard.branches[b].pop[i])
      //    $fwrite(fd, {env.scoreboard.branches[b].pop[i], "\n"});
      //  $fclose(fd);
      //end
      phase.drop_objection(this);
    endtask

  endclass
endpackage
