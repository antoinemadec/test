module top();
  import "DPI-C" context function void main(int argc, input string argv[64]);

  function void create_argv_from_plusargs(
    input string plusarg_str,
    output int argc,
    output string argv[64]
  );
    string args;
    int offset;
    offset = 0;
    argv[0] = "xrun_dpi";
    argc = 1;
    void'($value$plusargs($psprintf("%s%s", plusarg_str, "=%s"), args));
    for (int i=0; i<args.len(); i++) begin
      if (args.getc(i) == " ") begin
        argv[argc] = args.substr(offset,i-1);
        argc ++;
        while (args.getc(i) == " ")
          i++;
        offset = i;
      end
      if (i == args.len()-1) begin
        argv[argc] = args.substr(offset,args.len()-1);
        argc ++;
      end
    end
    assert (argc <= 64);
  endfunction

  initial
  begin
    int argc;
    string argv[64];
    create_argv_from_plusargs("args", argc, argv);
    #100;
    main(argc, argv);
    #100;
    $finish();
  end
endmodule
