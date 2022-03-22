class my_transaction extends uvm_sequence_item;
//  `uvm_object_utils(my_transaction)

  rand bit [31:0] data;
  `uvm_object_utils_begin(my_transaction)
    `uvm_field_int(data, UVM_ALL_ON|UVM_NOCOPY)
  `uvm_object_utils_end

  function new(string name = "");
    super.new(name);
  endfunction

 // function string convert2string;
 //   string s;
 //   $sformat(s, "0x%x", data);
 //   return s;
 // endfunction


 // function void do_print(uvm_printer printer);
 //     `uvm_info(get_full_name(), convert2string(), UVM_MEDIUM)
 // endfunction

 // function void do_copy(uvm_object rhs);
 //   my_transaction tx;
 //   $cast(tx, rhs);
 //   data = tx.data;
 // endfunction
endclass

class my_transaction_deadbeef extends my_transaction;
  `uvm_object_utils(my_transaction_deadbeef)

  function new(string name = "");
    super.new(name);
  endfunction

  constraint c {
    data == 32'hdeadbeef;
  }

endclass


class master_sequence extends uvm_sequence#(my_transaction);
  `uvm_object_utils(master_sequence)

  function new(string name = "");
    super.new(name);
  endfunction

  task body;
    my_transaction req;
    req = my_transaction::type_id::create("req",,get_full_name());
    repeat (16)
    begin
      start_item(req);
      if (!req.randomize())
        `uvm_error("MASTER_SEQUENCE", "could not randomize")
      finish_item(req);
    end
  endtask

endclass
