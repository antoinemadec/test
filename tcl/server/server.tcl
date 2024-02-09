#!/usr/bin/env tclsh

proc tcl_cmd_server {port} {
  set s [socket -server tcl_cmd_accept $port]
  vwait forever
}

proc tcl_cmd_accept {sock addr port} {
  # ensure that each "puts" by the server
  # results in a network transmission
  fconfigure $sock -buffering line
  # set up a callback for when the client sends data
  fileevent $sock readable [list tcl_cmd_eval $sock]
}

proc tcl_cmd_eval {sock} {
  gets $sock tcl_cmd
  eval $tcl_cmd
  puts $sock "tcl_cmd is done"
  close $sock
}

tcl_cmd_server 12345
