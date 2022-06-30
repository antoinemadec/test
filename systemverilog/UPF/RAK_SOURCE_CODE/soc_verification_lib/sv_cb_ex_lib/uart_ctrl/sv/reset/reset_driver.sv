/*******************************************************************************
  FILE : reset_driver.sv
*******************************************************************************/
//------------------------------------------------------------------------------
// CLASS: reset_driver declaration
//------------------------------------------------------------------------------

class reset_driver extends uvm_driver #(reset_transfer);

  // The virtual interface used to drive and view HDL signals.
  virtual reset_if vif;
  
  // Specify a default value of reset for time 0
  // Command-line override: +uvm_set_config_int="*,reset_value_at_time0,0"
  bit reset_value_at_time0 = 1;

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(reset_driver)
     `uvm_field_int(reset_value_at_time0, UVM_DEFAULT)
  `uvm_component_utils_end

  // Constructor which calls super.new() with appropriate parameters.
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Additional class methods
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual protected task drive_transfer (reset_transfer trans);

endclass : reset_driver

// UVM connect_phase - gets the vif as a config property
function void reset_driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if (!uvm_config_db#(virtual reset_if)::get(this, "", "vif", vif))
    `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
endfunction : connect_phase

// use UVM start_of_simulation_phase - to initialize resetN
function void reset_driver::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
  vif.resetN = reset_value_at_time0;
endfunction

// UVM run_phase
task reset_driver::run_phase(uvm_phase phase);
  forever begin
    seq_item_port.get_next_item(req);
    drive_transfer(req);
    seq_item_port.item_done();
  end
endtask : run_phase

// Drives a transfer when an item is ready to be sent.
task reset_driver::drive_transfer (reset_transfer trans);
  void'(begin_tr(trans, "reset driver", "UVM Debug", "reset transaction"));
  `uvm_info("RESET_DRIVER",
     $sformatf("RESET: delay %0d clocks duration of %0d clocks",
     trans.transmit_delay, trans.duration),
     UVM_LOW)
  if (trans.transmit_delay > 0)
    repeat(trans.transmit_delay) @(posedge vif.clock);
  `uvm_info("RESET_DRIVER", "Initiating RESET ", UVM_LOW)
  vif.resetN <= 0;
  repeat(trans.duration) @(posedge vif.clock);
  vif.resetN <= 1;
  `uvm_info("RESET_DRIVER", "Finished Driving RESET", UVM_LOW)
  end_tr(trans);
endtask : drive_transfer
