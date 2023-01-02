package test_pkg;
  import "DPI-C" context task test_run_dpi_c();

  class Toto;
    function new();
    endfunction

    task run();
      test_run_dpi_c();
    endtask
  endclass
endpackage
