/*-------------------------------------------------------------------------
File name   : reset_pkg.sv
Title       : Package for RESET UVC
Notes       :  
----------------------------------------------------------------------*/
package reset_pkg;

// Import the UVM class library  and UVM automation macros
import uvm_pkg::*;
`include "uvm_macros.svh"

// Only used if you are using the reset generator agent in a design
`include "reset_transfer.sv"
`include "reset_driver.sv"
`include "reset_agent.sv"
`include "reset_seq_lib.sv"
endpackage : reset_pkg
