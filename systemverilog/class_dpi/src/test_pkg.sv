package test_pkg;
  import "DPI-C" context task test_run_C();

  class Toto;
    function new();
    endfunction

    task run();
      test_run_C();
    endtask
  endclass
endpackage
