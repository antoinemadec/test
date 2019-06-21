----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:02:19 01/28/2008 
-- Design Name: 
-- Module Name:    LUT_filler - Behavioral 
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

------------------------------------------------------------
--La ram utilisée est une IP Xilinx : Dual block memory V6.3
------------------------------------------------------------
entity LUT_filler is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           data_sigmoid : in  STD_LOGIC_VECTOR (15 downto 0);
           LUT_en    : in  STD_LOGIC;
           LUT_rst   : in  STD_LOGIC;
           wrt       : out STD_LOGIC;
           adr       : out STD_LOGIC_VECTOR (10 downto 0);
           data      : out STD_LOGIC_VECTOR ( 8 downto 0);
           read_adr  : in  STD_LOGIC_VECTOR (10 downto 0);
			  --test
			  test_fill : out std_logic);
end LUT_filler;

architecture Behavioral of LUT_filler is

signal cmpt : std_logic_vector(10 downto 0);
signal fill : std_logic;

begin

test_fill<=fill;

data <= data_sigmoid(15 downto 7);
adr  <= cmpt when (fill='1' and LUT_en='1') else read_adr;
wrt  <= LUT_en and fill;

process(clk)
begin
if clk'event and clk='1' then
  if reset='1' or LUT_rst='1' then
    cmpt <= "00000000000";
    fill <= '1';
  elsif LUT_en = '1' then
    cmpt <= cmpt +1;
    if cmpt = "11111111111" then
      fill <= '0';
    end if;
  end if;
end if;
end process;

end Behavioral;

