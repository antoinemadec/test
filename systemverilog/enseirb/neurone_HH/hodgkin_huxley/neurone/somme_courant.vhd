----------------------------------------------------------------------------------
--somme des synchrone afin d'augment la fréquence de fonctionnement
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity somme_courant is
PORT( 
		H : in std_logic;
		i_Na,i_K,i_Ca,i_leak,i_stim : in std_logic_vector(31 downto 0);	
		der_Vmem : out std_logic_vector(31 downto 0)
		);
end somme_courant;

architecture Behavioral of somme_courant is
begin
process(H)
begin
	
	if (H' event and H='1')then
		der_Vmem<=std_logic_vector(signed(i_Na)+signed(i_K)+signed(i_Ca)+signed(i_leak)+signed(i_stim));-- les 14 derniers bits sont des bits de précision
	end if;

end process;	
end Behavioral;

