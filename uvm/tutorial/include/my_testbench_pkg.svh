package my_testbench_pkg;
  import uvm_pkg::*;

  // The UVM sequence, transaction item, and driver are in these files:
  `include "my_sequence.svh"
  `include "my_driver.svh"
  `include "my_monitor.svh"
  `include "my_scoreboard.svh"


  // The agent contains sequencer, driver, and monitor (not included)
  class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)

    my_driver driver;
    my_monitor monitor;
    uvm_sequencer#(my_transaction) sequencer;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      driver = my_driver::type_id::create("driver", this);
      monitor = my_monitor::type_id::create("monitor", this);
      sequencer = uvm_sequencer#(my_transaction)::type_id::create("sequencer", this);
    endfunction

    // In UVM connect phase, we connect the sequencer to the driver.
    function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

    task run_phase(uvm_phase phase);
    endtask

  endclass


  class my_env extends uvm_env;
    `uvm_component_utils(my_env)

    my_agent agent;
    my_scoreboard scoreboard;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      agent = my_agent::type_id::create("agent", this);
      scoreboard = my_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      agent.monitor.item_collected_port.connect(scoreboard.item_collected_export);
    endfunction

  endclass


  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    my_env env;
    my_sequence seq[2];

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      int i;
      env = my_env::type_id::create("env", this);
      for (i=0; i<2; i++)
        seq[i] = my_sequence::type_id::create($sformatf("seq%0d", i));
    endfunction

    task run_phase(uvm_phase phase);
      // We raise objection to keep the test from completing
      phase.raise_objection(this);
      begin
        int i;
        `uvm_warning("", "Hello World!")
        for (i=0; i<2; i++)
        begin
          automatic int th = i;
          seq[th].init(
            .thread          (th    ),
            .transaction_nb  (16    ),
            .add_min         (i*8   ),
            .add_max         (i*8+8 )
            );
          fork
            seq[th].start(env.agent.sequencer);
          join_none
        end
      end
      wait fork;
      // We drop objection to allow the test to complete
      phase.drop_objection(this);
    endtask

  endclass

endpackage
