library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity test_LUT is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           data_sigmoid : in  STD_LOGIC_VECTOR (15 downto 0);
           LUT_en    : in  STD_LOGIC;
			  test_fill : in std_logic;
			  remplissage_ram : out std_logic_vector(8 downto 0));
end test_LUT;

architecture Behavioral of test_LUT is

begin


process(clk)
begin
if clk'event and clk='1' then
  if reset='1' then
    remplissage_ram <= "000000000";
	 
  elsif (LUT_en = '1' and test_fill='1') then
    remplissage_ram <= data_sigmoid(15 downto 7);
	 
  end if;
end if;
end process;

end Behavioral;

