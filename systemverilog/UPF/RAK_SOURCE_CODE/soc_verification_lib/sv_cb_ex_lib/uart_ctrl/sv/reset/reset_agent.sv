/******************************************************************************
  FILE : reset_agent.sv
 ******************************************************************************/
//------------------------------------------------------------------------------
// CLASS: reset_agent
//------------------------------------------------------------------------------
class reset_agent extends uvm_agent;

  uvm_sequencer#(reset_transfer) sequencer;
  reset_driver    driver;

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(reset_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
  `uvm_component_utils_end

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  // Additional class methods
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : reset_agent

// UVM build_phase
function void reset_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(is_active == UVM_ACTIVE) begin
    sequencer = uvm_sequencer#(reset_transfer)::type_id::create("sequencer",this);
    driver = reset_driver::type_id::create("driver",this);
  end
endfunction : build_phase

// UVM connect_phase
function void reset_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if (is_active == UVM_ACTIVE) begin
    // Connect the driver to the sequencer using TLM interface
    driver.seq_item_port.connect(sequencer.seq_item_export);
  end
endfunction : connect_phase
