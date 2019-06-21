----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:29:47 01/28/2008 
-- Design Name: 
-- Module Name:    reduct_size - Behavioral 
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

entity reduct_size is
    Port ( clk    : in  STD_LOGIC;
           entree : in  STD_LOGIC_VECTOR ( 8 downto 0);
           signe  : in  STD_LOGIC;
           cmpt   : in  STD_LOGIC_VECTOR ( 2 downto 0);
           s0     : out STD_LOGIC_VECTOR ( 9 downto 0);
           s1     : out STD_LOGIC_VECTOR ( 9 downto 0);
           s2     : out STD_LOGIC_VECTOR ( 9 downto 0));
end reduct_size;

architecture Behavioral of reduct_size is

signal redress : std_logic_vector(9 downto 0);
signal s_buff  : std_logic;

begin

process(clk)
begin
if clk'event and clk='1' then
  s_buff <= signe;
  if s_buff='1' then
    redress <= '0' & (not entree);
  else
    redress <= '1' & entree;
  end if;
end if;
end process;


process(clk)
begin
if clk'event and clk='1' then
  case cmpt is
    when "000" => s0 <= redress;
    when "001" => s1 <= redress;
    when others => s2 <= redress;
  end case;
end if;
end process;




end Behavioral;

