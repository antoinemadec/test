proc my_proc_core {} {
  puts "my_proc_core"
}

proc my_proc {} {
  stop -name init_cb_breakpoint -execute my_proc_core -continue -time 1ns -delbreak 1
}

stop -name init_breakpoint -execute my_proc -continue -time 10ns
run
