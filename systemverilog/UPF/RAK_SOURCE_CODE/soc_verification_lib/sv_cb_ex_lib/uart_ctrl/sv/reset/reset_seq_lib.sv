/*******************************************************************************
  FILE : reset_seq_lib.sv
*******************************************************************************/
//------------------------------------------------------------------------------
// SEQUENCE: reset_base_seq  -  RESET sequences should derive from this
//------------------------------------------------------------------------------
class reset_base_seq extends uvm_sequence #(reset_transfer);

  function new(string name="reset_base_seq");
    super.new(name);
  endfunction
 
  `uvm_object_utils(reset_base_seq)

// Use a base sequence to raise/drop objections if this is a default sequence
  virtual task pre_body();
     if (starting_phase != null)
        starting_phase.raise_objection(this, {"Running sequence '",
                                              get_full_name(), "'"});
  endtask

  virtual task post_body();
     if (starting_phase != null)
        starting_phase.drop_objection(this, {"Completed sequence '",
                                             get_full_name(), "'"});
  endtask
endclass : reset_base_seq

//------------------------------------------------------------------------------
// SEQUENCE: reset_seq
//------------------------------------------------------------------------------
class reset_seq extends reset_base_seq;

  rand int unsigned transmit_del;
  rand int unsigned duration_time;

  function new(string name="reset_seq");
    super.new(name);
  endfunction
 
  `uvm_object_utils(reset_seq)

  constraint transmit_del_ct { transmit_del <= 10; }
  constraint duration_time_ct { duration_time inside {[1:5]}; }
    
  virtual task body();
    `uvm_info("RESET_SEQ", "Starting...", UVM_MEDIUM)
    `uvm_do_with(req, 
      { req.duration == duration_time;
        req.transmit_delay == transmit_del; } ) 
    endtask
endclass

//------------------------------------------------------------------------------
// SEQUENCE: two_reset_seq
//------------------------------------------------------------------------------
class two_reset_seq extends reset_base_seq;

  rand int unsigned transmit_del;
  rand int unsigned transmit_del2;
  rand int unsigned duration_time;

  function new(string name="two_reset_seq");
    super.new(name);
  endfunction
 
  `uvm_object_utils(two_reset_seq)

  constraint transmit_del_ct { transmit_del <= 10; }
  constraint transmit_del2_ct { transmit_del2 inside {[10:100]}; }
  constraint duration_time_ct { duration_time inside {[1:5]}; }
    
  virtual task body();
    `uvm_info("2_RESET_SEQ", "Starting...", UVM_MEDIUM)
    `uvm_create(req)
    void'(req.randomize() with 
      { req.duration == duration_time;
        req.transmit_delay == transmit_del; } );
    `uvm_send(req)
    req.transmit_delay = transmit_del2;
    `uvm_send(req)
  endtask
endclass

//------------------------------------------------------------------------------
// SEQUENCE: three_reset_seq
//------------------------------------------------------------------------------
class three_reset_seq extends reset_base_seq;

  rand int unsigned transmit_del;
  rand int unsigned transmit_del2;
  rand int unsigned duration_time;

  function new(string name="three_reset_seq");
    super.new(name);
  endfunction
 
  `uvm_object_utils(three_reset_seq)

  constraint transmit_del_ct { transmit_del <= 10; }
  constraint transmit_del2_ct { transmit_del2 inside {[30:100]}; }
  constraint duration_time_ct { duration_time inside {[1:5]}; }
    
  virtual task body();
    `uvm_info("3_RESET_SEQ", "Starting...", UVM_MEDIUM)
    `uvm_create(req)
    void'(req.randomize() with 
      { req.duration == duration_time;
        req.transmit_delay == transmit_del; } );
    `uvm_send(req)
    // Now invoke the reset two more times during the simulation
    req.transmit_delay = transmit_del2;
    repeat (2) begin
      `uvm_send(req)
    end
  endtask
endclass

//------------------------------------------------------------------------------
// SEQUENCE: delayed_reset_seq - 
//------------------------------------------------------------------------------
class delayed_reset_seq extends reset_base_seq;
  rand int unsigned transmit_del;
  rand int unsigned duration_time;

  function new(string name="delayed_reset_seq");
    super.new(name);
  endfunction
 
  `uvm_object_utils(delayed_reset_seq)

  constraint transmit_del_ct { transmit_del inside {[25:100]}; }
  constraint duration_time_ct { duration_time inside {[1:5]}; }
    
  virtual task body();
    `uvm_info("DLY_RESET_SEQ", $sformatf("Starting...delay:%0d  duration:%0d", transmit_del, duration_time), UVM_MEDIUM)
    `uvm_do_with(req, 
      { req.duration == duration_time;
        req.transmit_delay == transmit_del; } ) 
    endtask
endclass
