class my_transaction extends uvm_sequence_item;

  // no filed macro, override do_copy, do_print etc instead
  `uvm_object_utils(my_transaction)

  bit [31:0] thread;
  bit [31:0] add_min;
  bit [31:0] add_max;

  rand bit       rwb;
  rand bit [7:0] addr;
  rand bit [7:0] wdata;
  reg [7:0]      rdata;

  //Utility and Field macros,
  //`uvm_object_utils_begin(my_transaction)
  //  `uvm_field_int(addr,UVM_ALL_ON)
  //  `uvm_field_int(rwb,UVM_ALL_ON)
  //  `uvm_field_int(wdata,UVM_ALL_ON)
  //  `uvm_field_int(rdata,UVM_ALL_ON)
  // `uvm_object_utils_end

  constraint c_addr { addr >= add_min; addr < add_max; }
  constraint c_data { wdata >= 0; wdata < 256; }

  function new (string name = "");
    super.new(name);
  endfunction

  function string convert2string;
    string s;
    $sformat(s, "%s", super.convert2string());
    if (rwb)
      $sformat(s, " 0x%x<-[0x%x]", rdata, addr);
    else
      $sformat(s, " 0x%x->[0x%x]", wdata, addr);
    return s;
  endfunction

  function void do_copy(uvm_object rhs);
    my_transaction tx;
    $cast(tx, rhs);
    super.do_copy(rhs);
    rwb   = tx.rwb;
    addr  = tx.addr;
    rdata = tx.rdata;
    wdata = tx.wdata;
  endfunction

  function void do_print(uvm_printer printer);
    if (printer.knobs.sprint == 0)
      `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
    else
      printer.m_string = convert2string();
  endfunction


endclass: my_transaction


class my_sequence extends uvm_sequence#(my_transaction);

  `uvm_object_utils(my_sequence)

  bit[31:0] transaction_nb;

  function new (string name = "");
    super.new(name);
    req = my_transaction::type_id::create("req");
  endfunction

  function init (
    bit[31:0]   thread,
    bit[31:0]   transaction_nb,
    bit[31:0]   add_min,
    bit[31:0]   add_max
    );
    this.transaction_nb = transaction_nb;
    req.thread          = thread;
    req.add_min         = add_min;
    req.add_max         = add_max;
  endfunction

  task body;
    repeat(transaction_nb) begin
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "Randomize failed.");
      end
      finish_item(req);
    end
  endtask: body

endclass: my_sequence
