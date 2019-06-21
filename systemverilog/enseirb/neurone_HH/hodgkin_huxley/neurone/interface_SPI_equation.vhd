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
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity interface_SPI_equation is
PORT( 
		H : In std_logic;
		reset : In std_logic;
		signal_numerique1 : in std_logic_vector(11 downto 0);
		signal_numerique2 : in std_logic_vector(11 downto 0);
		
		DAC_CLR : out std_logic; --reset
	   DAC_CS : out std_logic;
		SPI_SCK : out std_logic;
		SPI_MOSI : out std_logic
		);
end interface_SPI_equation;


architecture Behavioral of interface_SPI_equation is

type etats IS(acquisition1, transmission1,acquisition2, transmission2);
signal i : unsigned (4 downto 0);
Signal etat : etats;
signal sig_MOSI : std_logic_vector (31 downto 0);

begin
process(H) --Partie compteur--
		  
Begin
		if (H' event and H='1') then
			if reset='1' then
				i <= "11111"; 
				DAC_CLR <= '0';
				etat<=acquisition1;
				
			else
				case etat is 
				
					when acquisition1 => 
						i <= "11111"; 
						DAC_CLR <= '1';
						DAC_CS <= '1';
						sig_MOSI <= "100000000011"& "0000" & (signal_numerique1 & "0000");
						etat <= transmission1;
						
					when transmission1 =>	
						DAC_CS<='0';
						SPI_MOSI <= sig_MOSI(to_integer(i));
						i<=i-1;
						if i="00000" then etat<=acquisition2; end if;
						
					when acquisition2 => 
						i <= "11111"; 
						DAC_CLR <= '1';
						DAC_CS <= '1';
						sig_MOSI <= "100000000011"& "0001" & (signal_numerique2 & "0000");
						etat <= transmission2;
						
					when transmission2 =>	
						DAC_CS<='0';
						SPI_MOSI <= sig_MOSI(to_integer(i));
						i<=i-1;
						if i="00000" then etat<=acquisition1; end if;
				end case;
			end if;
		end if;
end process;

SPI_SCK<=not(H); --horloge déphasée pour avoir des valeur de SPI_MOSI assez longues.

end Behavioral;

