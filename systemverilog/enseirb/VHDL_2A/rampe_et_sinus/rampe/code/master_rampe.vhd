----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:44:03 03/09/2009 
-- Design Name: 
-- Module Name:    master_quenching - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity master_rampe is
--déclaration des I/O de notre boite final
port(
		H : In std_logic;
		reset : In std_logic;

		DAC_CLR : out std_logic; --reset
	   DAC_CS : out std_logic;
		SPI_SCK : out std_logic;
	SPI_MOSI : out std_logic
--		test1 : out std_logic;
--		test2 : out std_logic;
--		test3 : out std_logic
		

);
end master_rampe;

architecture structurelle of master_rampe is

--déclaration signaux nécessaires au branchement des composants
signal 		signal_numerique : std_logic_vector(11 downto 0);
signal		H_numerique, Hdiv : std_logic;

--déclaration composants
component interface_SPI is
PORT( 
		H : In std_logic;
		reset : In std_logic;
		signal_numerique : in std_logic_vector(11 downto 0);
		
		DAC_CLR : out std_logic; --reset
	   DAC_CS : out std_logic;
		H_numerique : out std_logic;
		SPI_SCK : out std_logic;
		SPI_MOSI : out std_logic
		);
end component;

component generateur_rampe is
PORT( 
		H,H_numerique, reset: In std_logic;
		signal_numerique : out std_logic_vector(11 downto 0)
		);
end component;

component diviseur_clock is
PORT( 
		H,reset: In std_logic;
		Hdiv: out std_logic
		);
end component;



--instanciation
begin

b1: interface_SPI
						port map(Hdiv,reset,signal_numerique,DAC_CLR,DAC_CS,H_numerique,SPI_SCK,SPI_MOSI);
						

b2: generateur_rampe			
						port map(Hdiv,H_numerique,reset,signal_numerique);
						
b3 : diviseur_clock
						port map(H,reset,Hdiv);

----tests						
--test1 <= DAC_CS;
--test2 <= SPI_MOSI;
--test3 <= DAC_CLR;
				
end structurelle;
