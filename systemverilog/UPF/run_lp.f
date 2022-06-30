
#-------------------------------------------------------------------------
# File name   : Makefile
# Title       :
# Project     : APB Subsystem Level Verification
# Created     :
# Description :
# Notes       :
#----------------------------------------------------------------------
#   Copyright 1999-2010 Cadence Design Systems, Inc.
#   All Rights Reserved Worldwide
#
#   Licensed under the Apache License, Version 2.0 (the
#   "License"); you may not use this file except in
#   compliance with the License.  You may obtain a copy of
#   the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in
#   writing, software distributed under the License is
#   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
#   CONDITIONS OF ANY KIND, either express or implied.  See
#   the License for the specific language governing
#   permissions and limitations under the License.
#----------------------------------------------------------------------


-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/ahb/sv \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/apb/sv \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/uart/sv \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/spi/sv \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/gpio/sv \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/uart_ctrl/sv \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/uart_ctrl/sv/sequence_lib \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/uart_ctrl/sv/reset \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/sv \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/sv/sequence_lib  \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/tb/sv  \
-incdir ${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/tb/tests \
${RAK_SOURCE_CODE}/designs/socv/rtl/rtl_lpw/opencores/uart16550/rtl/uart_defines.v \
${RAK_SOURCE_CODE}/designs/socv/rtl/rtl_lpw/opencores/spi/rtl/spi_defines.v \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/sv/gpio_defines.svh \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/sv/spi_defines.svh \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/uart_ctrl/sv/reset/reset_pkg.sv \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/uart_ctrl/sv/reset/reset_if.sv \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/uart_ctrl/sv/uart_ctrl_defines.svh \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/sv/apb_subsystem_defines.svh \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/ahb/sv/ahb_pkg.sv \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/apb/sv/apb_pkg.sv \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/uart/sv/uart_pkg.sv \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/gpio/sv/gpio_pkg.sv \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/interface_uvc_lib/spi/sv/spi_pkg.sv \
-F ${RAK_SOURCE_CODE}/designs/socv/rtl/rtl_lpw/apb_subsystem/rtl/apb_subsystem.irunargs \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/uart_ctrl/sv/uart_ctrl_pkg.sv \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/sv/apb_subsystem_pkg.sv \
+tcl+${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/tb/scripts/assert_opt.tcl \
-assert_count_traces \
${RAK_SOURCE_CODE}/soc_verification_lib/sv_cb_ex_lib/apb_subsystem/tb/sv/apb_subsystem_top.sv \
+UVM_VERBOSITY=MEDIUM \
+define+LITLE_ENDIAN \
+svseed+1 \
-TIMESCALE 1ns/10ps \
+define+UART_ABV_ON 
