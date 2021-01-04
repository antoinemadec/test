class my_transaction extends uvm_sequence_item;
//  `uvm_object_utils(my_transaction)

  rand bit [31:0] data;
  `uvm_object_utils_begin(my_transaction)
    `uvm_field_int(data, UVM_ALL_ON|UVM_NOCOPY)
  `uvm_object_utils_end

  function new(string name = "");
    super.new(name);
  endfunction
endclass


class master_sequence extends uvm_sequence#(my_transaction);

  static int unsigned transaction_nb = 32;  // min = 16

  rand int unsigned close_xaction_nb_q[$];
  rand int unsigned not_close_xaction_nb_q[$];
  rand int unsigned close_not_close_ratio;
  rand int unsigned uncloseness;
  rand int unsigned max_xaction_nb_per_cycle;

  `uvm_object_utils_begin(master_sequence)
    `uvm_field_int(max_xaction_nb_per_cycle,UVM_ALL_ON);
    `uvm_field_int(close_not_close_ratio,UVM_ALL_ON)
    `uvm_field_int(uncloseness,UVM_ALL_ON)
  `uvm_object_utils_end

  constraint c {
    // constraints changing sequence
    close_not_close_ratio    inside {2,3};
    uncloseness              inside {[4:8]};
    max_xaction_nb_per_cycle inside {[transaction_nb>>4:transaction_nb>>2]};
    // other constraints
    close_xaction_nb_q.size()     inside {[1<<2:transaction_nb]};
    not_close_xaction_nb_q.size() == close_xaction_nb_q.size();
    (close_xaction_nb_q.sum() + not_close_xaction_nb_q.sum()) == transaction_nb;
    foreach (close_xaction_nb_q[i]) {
      close_xaction_nb_q[i]     inside {[1:max_xaction_nb_per_cycle>>1]};
    }
    foreach (not_close_xaction_nb_q[i]) {
      not_close_xaction_nb_q[i] inside {[1:max_xaction_nb_per_cycle>>1]};
      (close_xaction_nb_q[i]<<close_not_close_ratio) <= not_close_xaction_nb_q[i];
    }
  }

  function new(string name = "");
    super.new(name);
    assert(transaction_nb>=16);
  endfunction

  task body;
    my_transaction req;
    req = my_transaction::type_id::create("req",,get_full_name());
    while (close_xaction_nb_q.size() || not_close_xaction_nb_q.size())
    begin
      int unsigned close_xaction_nb;
      int unsigned not_close_xaction_nb;
      // get next number for close and not close
      if (close_xaction_nb_q.size())
        close_xaction_nb = close_xaction_nb_q.pop_front();
      else
        close_xaction_nb = 0;
      if (not_close_xaction_nb_q.size())
        not_close_xaction_nb = not_close_xaction_nb_q.pop_front();
      else
        not_close_xaction_nb = 0;
      // randomize xaction
      repeat (close_xaction_nb)
      begin
        start_item(req);
        if (!req.randomize() with {data < uncloseness;})
          `uvm_error("MASTER_SEQUENCE", "could not randomize")
        finish_item(req);
      end
      repeat (not_close_xaction_nb)
      begin
        start_item(req);
        if (!req.randomize())
          `uvm_error("MASTER_SEQUENCE", "could not randomize")
        finish_item(req);
      end
    end
  endtask

endclass
