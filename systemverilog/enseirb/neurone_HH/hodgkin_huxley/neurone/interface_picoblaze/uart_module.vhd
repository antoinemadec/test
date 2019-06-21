--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1.03i
--  \   \         Application : sch2vhdl
--  /   /         Filename : uart_module.vhf
-- /___/   /\     Timestamp : 01/06/2009 07:38:28
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx91i\bin\nt\sch2vhdl.exe -intstyle ise -family spartan3e -flat -suppress -w F:/VHDL/Kit_sp3e/ordimini/uart_module.sch uart_module.vhf
--Design Name: uart_module
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesis and simulted, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity uart_module is
   port ( clk        : in    std_logic; 
          pblaze_out : in    std_logic_vector (7 downto 0); 
          pblaze_r   : in    std_logic; 
          pblaze_w   : in    std_logic; 
          port_id    : in    std_logic_vector (7 downto 0); 
          reset      : in    std_logic; 
          RX         : in    std_logic; 
          pblaze_in  : out   std_logic_vector (7 downto 0); 
          TX         : out   std_logic);
end uart_module;

architecture BEHAVIORAL of uart_module is
   signal channel    : std_logic;
   signal rx_read    : std_logic;
   signal tx_wrt     : std_logic;
   signal XLXN_10    : std_logic;
   signal XLXN_11    : std_logic_vector (7 downto 0);
   signal XLXN_41    : std_logic_vector (7 downto 0);
   signal XLXN_42    : std_logic;
   signal XLXN_43    : std_logic;
   component recv115k
      port ( clk    : in    std_logic; 
             reset  : in    std_logic; 
             rx     : in    std_logic; 
             dat_en : out   std_logic; 
             dat    : out   std_logic_vector (7 downto 0));
   end component;
   
   component send115k
      port ( clk   : in    std_logic; 
             reset : in    std_logic; 
             wrt   : in    std_logic; 
             dat   : in    std_logic_vector (7 downto 0); 
             TX    : out   std_logic; 
             busy  : out   std_logic);
   end component;
   
   component uart_mgr
      port ( clk      : in    std_logic; 
             rx_dv    : in    std_logic; 
             rd       : in    std_logic; 
             rx_dev   : in    std_logic_vector (7 downto 0); 
             inc_data : out   std_logic; 
             rx_int   : out   std_logic_vector (7 downto 0));
   end component;
   
   
   component UART_loc_IF
      port ( clk        : in    std_logic; 
             reset      : in    std_logic; 
             pblaze_r   : in    std_logic; 
             pblaze_w   : in    std_logic; 
             tx_busy    : in    std_logic; 
             rx_rdy     : in    std_logic; 
             port_id    : in    std_logic_vector (7 downto 0); 
             pblaze_out : in    std_logic_vector (7 downto 0); 
             rx_dat     : in    std_logic_vector (7 downto 0); 
             channel    : out   std_logic; 
             tx_wrt     : out   std_logic; 
             rx_read    : out   std_logic; 
             pblaze_in  : out   std_logic_vector (7 downto 0));
   end component;
   
begin
   XLXI_1 : recv115k
      port map (clk=>clk,
                reset=>reset,
                rx=>RX,
                dat(7 downto 0)=>XLXN_11(7 downto 0),
                dat_en=>XLXN_10);
   
   XLXI_2 : send115k
      port map (clk=>clk,
                dat(7 downto 0)=>pblaze_out(7 downto 0),
                reset=>reset,
                wrt=>tx_wrt,
                busy=>XLXN_42,
                TX=>TX);
   
   XLXI_3 : uart_mgr
      port map (clk=>clk,
                rd=>rx_read,
                rx_dev(7 downto 0)=>XLXN_11(7 downto 0),
                rx_dv=>XLXN_10,
                inc_data=>XLXN_43,
                rx_int(7 downto 0)=>XLXN_41(7 downto 0));
   
   XLXI_5 : UART_loc_IF
      port map (clk=>clk,
                pblaze_out(7 downto 0)=>pblaze_out(7 downto 0),
                pblaze_r=>pblaze_r,
                pblaze_w=>pblaze_w,
                port_id(7 downto 0)=>port_id(7 downto 0),
                reset=>reset,
                rx_dat(7 downto 0)=>XLXN_41(7 downto 0),
                rx_rdy=>XLXN_43,
                tx_busy=>XLXN_42,
                channel=>open,
                pblaze_in(7 downto 0)=>pblaze_in(7 downto 0),
                rx_read=>rx_read,
                tx_wrt=>tx_wrt);
   
end BEHAVIORAL;


