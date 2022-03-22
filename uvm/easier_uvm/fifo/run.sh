#!/usr/bin/env bash

set -e

#--------------------------------------------------------------
# functions
#--------------------------------------------------------------
error() {
  >&2 echo "ERROR: $@"
  exit 1
}


#--------------------------------------------------------------
# execution
#--------------------------------------------------------------
[ -f generated_tb/sim/compile_ius.sh ] || error "generated_tb/tb/compile_ius.sh does not exist"

cd generated_tb/sim
./compile_ius.sh -access +rw +UVM_VERBOSITY=UVM_HIGH -q -gui
