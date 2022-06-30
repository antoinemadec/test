/*******************************************************************************
  FILE : reset_transfer.svh
*******************************************************************************/
//   Copyright 1999-2010 Cadence Design Systems, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------


//------------------------------------------------------------------------------
// CLASS: reset_transfer declaration
//------------------------------------------------------------------------------
class reset_transfer extends uvm_sequence_item;                                  
  rand int unsigned  transmit_delay;
  rand int unsigned  duration;
   
  constraint c_transmit_delay { transmit_delay <= 10 ; }
  constraint c_duration { duration inside {[0:5]}; }

  `uvm_object_utils_begin(reset_transfer)
    `uvm_field_int(transmit_delay, UVM_DEFAULT)
    `uvm_field_int(duration, UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "reset_transfer");
    super.new(name);
  endfunction

endclass : reset_transfer
