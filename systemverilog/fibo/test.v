
module main();
  bit clk;
  initial
  forever #5 clk = ~clk;

  int cache_assoc[*];
  initial
  begin
    cache_assoc[0] = 0;
    cache_assoc[1] = 1;
  end

  function automatic int fibo(int n);
    if ((n==0) || (n==1))
    begin
      return 1;
    end
    else
      return fibo(n-1) + fibo(n-2);
  endfunction

  function automatic int fibo_cache(int n);
    if (!cache_assoc.exists(n))
      cache_assoc[n] = fibo_cache(n-1) + fibo_cache(n-2);
    return cache_assoc[n];
  endfunction

  initial
  begin
    // $display(fibo(42));
    $display(fibo_cache(64));
    $finish();
  end

  initial
  begin
    // simvision
    $shm_open("waves.shm");
    $shm_probe("ACMTF");
  end
endmodule
