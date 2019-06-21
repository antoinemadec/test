library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity soustraction3 is
--déclaration des I/O de notre boite final
port(
		N_inf,N : in std_logic_vector(15 downto 0);
		der_N : out std_logic_vector(15 downto 0)		
		);
end soustraction3;


architecture structurelle of soustraction3 is
begin

der_N<=std_logic_vector(signed(N_inf)-signed(N));
						

end structurelle;
