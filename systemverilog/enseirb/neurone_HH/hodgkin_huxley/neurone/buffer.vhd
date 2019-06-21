--------------------------------------------------------------
--buffer pour augmenter la fréquence de fonctionnement
--------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity buffer_g is
PORT( 
		H			: In std_logic;
		g_in_Na	: in std_logic_vector(15 downto 0);
		g_in_K	: in std_logic_vector(15 downto 0);	
		g_in_Ca	: in std_logic_vector(15 downto 0);			
		g_out_Na	: out std_logic_vector(15 downto 0);
		g_out_K	: out std_logic_vector(15 downto 0);
		g_out_Ca	: out std_logic_vector(15 downto 0)
		);
end buffer_g;

architecture Behavioral of buffer_g is
begin

process(H)	  
Begin
		if (H' event and H='1') then
			g_out_Na	<=g_in_Na;
			g_out_K	<=g_in_K;
			g_out_Ca	<=g_in_Ca;
		end if;
end process;
end Behavioral;