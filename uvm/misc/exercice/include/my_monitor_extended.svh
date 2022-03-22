class my_monitor_extended #(parameter PASSIVE=0) extends my_monitor#(PASSIVE);
  `uvm_component_param_utils(my_monitor_extended#(PASSIVE))

  function new(string name, uvm_component parent);
    super.new(name, parent);
    $display("DBG: using extended monitor in %s", get_full_name());
  endfunction

endclass
