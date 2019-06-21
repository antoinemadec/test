----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:15:08 01/06/2009 
-- Design Name: 
-- Module Name:    UART_loc_IF - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_loc_IF is
    Port ( clk         : in  STD_LOGIC;
           reset       : in  STD_LOGIC;
           port_id     : in  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_in   : out STD_LOGIC_VECTOR (7 downto 0);
           pblaze_out  : in  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_r    : in  STD_LOGIC;
           pblaze_w    : in  STD_LOGIC;
           
           channel     : out STD_LOGIC;
           tx_wrt      : out STD_LOGIC;
           rx_read     : out STD_LOGIC;
           rx_dat      : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_busy     : in  STD_LOGIC;
           rx_rdy      : in  STD_LOGIC);
end UART_loc_IF;

architecture Behavioral of UART_loc_IF is

constant base_addr : std_logic_vector(7 downto 0):= "00000010";
constant reg_addr  : std_logic_vector(7 downto 0):= "00000011";  -- base_addr + 1


signal channel_int : std_logic;

begin

channel <= channel_int;
tx_wrt  <= pblaze_w when port_id = reg_addr else '0';
rx_read <= pblaze_r when port_id = reg_addr else '0';

process(port_id,rx_dat,channel_int,tx_busy,rx_rdy)
begin
case port_id is
  when base_addr  => pblaze_in <= "00000" & channel_int & tx_busy & rx_rdy;
  when reg_addr   => pblaze_in <= rx_dat;
  when others     => pblaze_in <= "00000000";
end case;
end process;

process(clk)
begin
if clk'event and clk='1' then
  if reset='1' then
    channel_int <= '0';
  elsif port_id = base_addr and pblaze_w='1' then
    channel_int <= pblaze_out(2);
  end if;
end if;
end process;


end Behavioral;

