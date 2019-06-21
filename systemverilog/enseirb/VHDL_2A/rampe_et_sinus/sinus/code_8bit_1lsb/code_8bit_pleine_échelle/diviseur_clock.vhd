----------------------------------------------------------------------------------
-- Company: IMS
-- Engineer: MADEC Antoine
-- 
-- Create Date:    10:48:45 05/09/2009 
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

--  Divise par 10 !
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity diviseur_clock is
PORT( 
		H,reset: In std_logic;
		Hdiv: out std_logic
		);
end diviseur_clock;


architecture Behavioral of diviseur_clock is

type etats IS( notHdiv, compteur);
signal i : unsigned (1 downto 0);
signal sig_Hdiv : std_logic;
Signal etat : etats;

begin

Hdiv<=H;

--process(H) --Partie compteur--
--		  
--Begin
--		if (H' event and H='1') then
--			if reset='1' then
--				sig_Hdiv <= '0';
--				i<="00";
--				etat<=compteur;
--			else 
--				case etat is
--					when compteur => 	i<=i+1;
--											if i="10" then etat <= notHdiv; -- divise par 10 pour i="10"
--											end if;
--											
--					when notHdiv => 	sig_Hdiv <= not(sig_Hdiv);
--											etat<=compteur;
--											
--					end case;
--			end if;
--		end if;
--end process;
--
--Hdiv<=sig_Hdiv;

end Behavioral;

