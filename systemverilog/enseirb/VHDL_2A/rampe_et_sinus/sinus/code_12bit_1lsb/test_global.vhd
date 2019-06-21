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

component master_rampe is
port(
		H : In std_logic;
		reset : In std_logic;

		DAC_CLR : out std_logic; --reset
	   DAC_CS : out std_logic;
		SPI_SCK : out std_logic;
		SPI_MOSI : out std_logic
);
end component;





--déclaration signaux : "stimuli" et sortie
signal H,reset: std_logic :='0';
signal DAC_CLR, DAC_CS, SPI_SCK, SPI_MOSI : std_logic;



--déclaration constantes
constant demi_periode : time := 10 ns;

--Instanciation
begin
test: master_rampe
						port map(H,reset,DAC_CLR,DAC_CS,SPI_SCK,SPI_MOSI);

--process horloge						
 horloge : process
 begin
	H<=not(H);
	wait for demi_periode;
 end process horloge;


--valeurs tests
valeurs_test : process
begin
      reset<='0';
		wait for demi_periode*2;
		reset<='1';
		wait for demi_periode*2;
		reset<='0';
		wait for demi_periode*2000;


end process valeurs_test;
		
end Behavioral;

