#!/usr/bin/env bash

set -e

export RAK_SOURCE_CODE=$PWD/RAK_SOURCE_CODE

mkdir -p output
cp -rf input.tcl run_lp.f lp_debug.svcf 1801/ output/
cd output

xrun -q                           \
  -uvmhome CDNS-1.2               \
  -define UPF                     \
  -covoverwrite                   \
  -lps_1801 ./1801/testbench.upf \
  -lps_viso                  \
  -lps_v10_ack               \
  -lps_replay_comb_always    \
  -lps_bit_precise_sr        \
  -lps_bind_aon              \
  -lps_rsdrv                 \
  -lps_snstate_hierfind      \
  -lps_modules_wildcard      \
  -lps_sv_interface_port     \
  -lps_relax_1801            \
  -lps_enable_assertion_ctrl \
  -prsw_output_override      \
  -lps_verbose 4             \
  -lps_smartlog_enable       \
  -lps_isofilter_verbose     \
  -lps_iso_verbose           \
  -lps_psn_verbose 2         \
  -lps_lib_verbose 4         \
  -lps_pst_verbose           \
  -lps_logfile lps.log       \
  -sv \
  -f ./run_lp.f                  \
  +UVM_TESTNAME=lp_shutdown_urt1  \
  -gui -access rwc                \
  -define UVM1_2                  \
  -xmwarn UPFNDEF                 \
  -input ./input.tcl
