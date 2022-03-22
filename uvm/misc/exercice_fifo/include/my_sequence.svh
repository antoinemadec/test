class my_transaction extends uvm_sequence_item;
  `uvm_object_utils(my_transaction)

  rand int data;

  function new(string name = "");
    super.new(name);
  endfunction
endclass

class my_sequence extends uvm_sequence#(my_transaction);
  `uvm_object_utils(my_sequence)

  rand int xaction_nb;

  constraint c {
    xaction_nb inside {[1:128]};
  }

  function new(string name = "");
    super.new(name);
    xaction_nb = 16;
  endfunction

  task body();
    my_transaction req;
    req = my_transaction::type_id::create("req");
    repeat (xaction_nb)
    begin
      start_item(req);
      if (!req.randomize())
        `uvm_error("SEQUENCE", "could not randomize")
      finish_item(req);
    end
  endtask
endclass
