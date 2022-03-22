class my_transaction extends uvm_sequence_item;
//  `uvm_object_utils(my_transaction)

  rand bit [31:0] data;
  rand bit dst;
  bit src;
  `uvm_object_utils_begin(my_transaction)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(dst, UVM_ALL_ON)
    `uvm_field_int(src, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "");
    super.new(name);
  endfunction
endclass


class master_sequence extends uvm_sequence#(my_transaction);
  `uvm_object_utils(master_sequence)

  static int transaction_nb = 16;

  function new(string name = "");
    super.new(name);
    assert(transaction_nb>=16);
  endfunction

  task body;
    my_transaction req;
    req = my_transaction::type_id::create("req",,get_full_name());
    repeat (transaction_nb)
    begin
      start_item(req);
      if (!req.randomize())
        `uvm_error("MASTER_SEQUENCE", "could not randomize")
      finish_item(req);
    end
  endtask

endclass
