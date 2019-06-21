
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

--ecrit les paramètres par bout de 8 bits

entity parametres_picoblaze is
PORT( 
		H,reset 					: In std_logic;
		Port_Id 					: in std_logic_vector(7 downto 0);
		WE 						: in std_logic;
		data 						: in std_logic_vector(7 downto 0);
		parametres			 	: out std_logic_vector(511 downto 0)
		);
end parametres_picoblaze;


architecture Behavioral of parametres_picoblaze is


begin


process(H,reset)
		  
Begin

	if (H' event and H='1') then
	
		if (to_integer(unsigned(Port_Id))>127) and (to_integer(unsigned(Port_Id))<128+64) then
		
			if reset='1' then
				parametres<=std_logic_vector(to_unsigned(0,240));
			else 
					if WE='1' then
						parametres((8*to_integer(unsigned(Port_Id)-128)+ 7) downto (8*to_integer(unsigned(Port_Id)-128)))<=data; --parametre([8*(addr-128) + 7] downto [8*(addr-128)])<=data;									
					end if;
			end if;
			
		else Null;
		
	end if;
end if;

end process;


end Behavioral;

