----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:57 11/24/2008 
-- Design Name: 
-- Module Name:    uart_mgr - Behavioral 
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

entity uart_mgr is
    Port ( clk      : in  STD_LOGIC;
           rx_dev   : in  STD_LOGIC_VECTOR (7 downto 0);
           rx_int   : out STD_LOGIC_VECTOR (7 downto 0);
           rx_dv    : in  STD_LOGIC;
           rd       : in  STD_LOGIC;
           inc_data : out STD_LOGIC);
end uart_mgr;

architecture Behavioral of uart_mgr is

begin

process(clk)
begin
  if clk'event and clk='1' then
    if rx_dv='1' then
      inc_data <= '1';
      rx_int <= rx_dev;
    elsif rd='1' then
      inc_data <= '0';
    end if;
  end if;
end process;



end Behavioral;

