----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:19:35 09/26/2008 
-- Design Name: 
-- Module Name:    test_bench - Behavioral 
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
use IEEE.STD_LOGIC_TEXTIO.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_bench is
end entity test_bench;

architecture Behavioral of test_bench is

--déclaration composant(s)

component generateur_sinus_racine2sur2 is
PORT( 
		H,enable, reset: In std_logic;
		signal_numerique : out std_logic_vector(11 downto 0)
		);
end component;





--déclaration signaux : "stimuli" et sortie
signal H,enable,reset: std_logic :='0';
signal signal_numerique : std_logic_vector(11 downto 0);



--déclaration constantes
constant demi_periode : time := 10 ns;

--Instanciation
begin
test: generateur_sinus_racine2sur2
						port map(H,enable, reset,signal_numerique);

--process horloge						
 horloge : process
 begin
	H<=not(H);
	enable<=not(enable);
	wait for demi_periode;
 end process horloge;


--valeurs tests
valeurs_test : process
begin
      reset<='0';
		wait for demi_periode*2;
		reset<='1';
		wait for demi_periode*20;
		reset<='0';
		wait for demi_periode*2000000;


end process valeurs_test;
		
end Behavioral;

