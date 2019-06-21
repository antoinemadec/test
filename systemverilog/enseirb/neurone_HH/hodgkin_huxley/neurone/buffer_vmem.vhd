library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity buffer_Vmem is
PORT( 
		H			: In std_logic;
		Vmem		: in std_logic_vector(15 downto 0);			
		Vmem_buff: out std_logic_vector(15 downto 0)
		);
end buffer_Vmem;


architecture Behavioral of buffer_Vmem is
begin

process(H)	  
Begin
		if (H' event and H='1') then
			Vmem_buff<=Vmem;
		end if;
end process;
end Behavioral;