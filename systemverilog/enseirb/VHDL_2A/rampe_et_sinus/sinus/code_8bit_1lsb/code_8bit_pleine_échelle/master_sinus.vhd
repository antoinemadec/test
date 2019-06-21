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


entity master_sinus is
--déclaration des I/O de notre boite final
port(
		H : In std_logic;
		reset : In std_logic;

		DAC_CLR : out std_logic; --reset
	   DAC_CS : out std_logic;
		SPI_SCK : out std_logic;
	SPI_MOSI : out std_logic;
		test1 : out std_logic;
		test2 : out std_logic
		

);
end master_sinus;

architecture structurelle of master_sinus is

--déclaration signaux nécessaires au branchement des composants
signal 		signal_numerique : std_logic_vector(7 downto 0);
signal 		signal_numerique_12bit : std_logic_vector(11 downto 0);
signal		enable, Hdiv : std_logic;

--déclaration composants
component interface_SPI is
PORT( 
		H : In std_logic;
		reset : In std_logic;
		signal_numerique : in std_logic_vector(11 downto 0);
		
		DAC_CLR : out std_logic; --reset
	   DAC_CS : out std_logic;
		enable : out std_logic;
		SPI_SCK : out std_logic;
		SPI_MOSI : out std_logic
		);
end component;

component generateur_sinus_racine2sur2 is
PORT( 
		H,enable, reset: In std_logic;
		signal_numerique : out std_logic_vector(7 downto 0);
		test1 : out std_logic;
		test2 : out std_logic
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

signal_numerique_12bit<=signal_numerique&"0000";

b1: interface_SPI
						port map(Hdiv,reset,signal_numerique_12bit,DAC_CLR,DAC_CS,enable,SPI_SCK,SPI_MOSI);
						

b2: generateur_sinus_racine2sur2			
						port map(Hdiv,enable,reset,signal_numerique,test1,test2);
						
b3 : diviseur_clock
						port map(H,reset,Hdiv);

end structurelle;
