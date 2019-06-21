----------------------------------------------------------------------------------
--chaque bit ouvre ou ferme une branche : interrupteur ="Na K Ca leak stim"
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity interrupteur_courant is
PORT( 
		interrupteur : in std_logic_vector(4 downto 0);
		i_Na,i_K,i_Ca,i_leak,i_stim : in std_logic_vector(31 downto 0);
		i_Na_out,i_K_out,i_Ca_out,i_leak_out,i_stim_out : out std_logic_vector(31 downto 0)
		);
end interrupteur_courant;

architecture Behavioral of interrupteur_courant is
begin
process(i_Na,i_K,i_Ca,i_leak,i_stim,interrupteur)--interrupteur
	begin
		if(interrupteur(4)='0')then
			i_Na_out<=i_Na;
			else i_Na_out<="00000000000000000000000000000000";
		end if;
		if(interrupteur(3)='0')then
			i_K_out<=i_K;
			else i_K_out<="00000000000000000000000000000000";
		end if;
		if(interrupteur(2)='0')then
			i_Ca_out<=i_Ca;
			else i_Ca_out<="00000000000000000000000000000000";
		end if;
		if(interrupteur(1)='0')then
			i_leak_out<=i_leak;
			else i_leak_out<="00000000000000000000000000000000";
		end if;
		if(interrupteur(0)='0')then
			i_stim_out<=i_stim;
			else i_stim_out<="00000000000000000000000000000000";
		end if;
	end process;
end Behavioral;

