----------------------------------------------------------------------------------
-- Company: IMS
-- Engineer: MADEC Antoine
-- 
-- Create Date:    10:48:45 03/09/2009 
-- Design Name: 
-- Module Name:    generateur_rampe - Behavioral 
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
use IEEE.numeric_std.ALL;


entity generateur_rampe is
PORT( 
		H,H_numerique, reset: In std_logic;
		signal_numerique : out std_logic_vector(11 downto 0)
		);
end generateur_rampe;


architecture Behavioral of generateur_rampe is

type etats IS( montee, descente);
signal i : unsigned (11 downto 0);
Signal etat : etats;

begin

process(H,reset) --Partie compteur--
		  
Begin
--reset asynchrone
		if reset='1' then
				i<="000000000000";
				etat<=montee;
		
		elsif (H' event and H='1') then
			if H_numerique='1' then
				case etat is 
				
					when montee => i <= i + 1;
					if i="111111111110" then etat<=descente; end if;
				
					when descente => i <= i - 1;
						if i="000000000001" then etat<=montee; end if;
						
				end case;

			end if;
		end if;
end process;

signal_numerique <= std_logic_vector(i);

end Behavioral;

