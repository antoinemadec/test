#!/usr/bin/env tclsh

proc tcl_cmd_send {host port tcl_cmd} {
  set s [socket $host $port]
  fconfigure $s -buffering line
  puts $s "$tcl_cmd"
  gets $s server_response
}

tcl_cmd_send "localhost" 12345 {source input.tcl}
tcl_cmd_send "localhost" 12345 {exit}
