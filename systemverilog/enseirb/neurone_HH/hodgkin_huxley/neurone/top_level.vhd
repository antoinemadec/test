----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:   16/09/2009 
-- Design Name: 
-- Module Name:    top_level - Behavioral 
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

entity top_level is
port(
		H 			: In std_logic;
		reset 	: In std_logic;
		reset_2 	: In std_logic;--Vmem et tau à 0
		
		DAC_CLR 	: out std_logic;
	   DAC_CS 	: out std_logic;
		SPI_SCK 	: out std_logic;
		SPI_MOSI : out std_logic;
		
		switches	: in std_logic_vector(3 downto 0);
		Rx 		: in std_logic;
		Tx			: out std_logic;
		LED		: out std_logic_vector(7 downto 0);
		
		test1 	: out std_logic;
		test_lut_en : out std_logic;
		test_lut_rst : out std_logic;
		test_fill : out std_logic
);
end top_level;

architecture structurelle of top_level is
--signaux
		--branchement
signal enable 			: std_logic;
signal mesure1_12bit : std_logic_vector(11 downto 0);
signal mesure2_12bit : std_logic_vector(11 downto 0);
signal parametres		: std_logic_vector(511 downto 0);

signal data_sigmoid	: std_logic_vector(15 downto 0);
signal LUT_en 			: std_logic;
signal LUT_rst 		: std_logic;


--déclaration composants
component master_picoblaze is
port(
		clk 			: In std_logic;
		reset			: In std_logic;
		switches 	: In std_logic_vector(3 downto 0);
		Rx 			: in std_logic;
		LED 			: out std_logic_vector(7 downto 0);
		Tx 			: out std_logic;
		parametres	: out std_logic_vector(511	downto 0);
		
		data_sigmoid: out STD_LOGIC_VECTOR (15 downto 0);
      lut_en      : out STD_LOGIC;
      lut_rst     : out STD_LOGIC

);
end component;

component interface_SPI_equation is
PORT( 
		H : In std_logic;
		reset : In std_logic;
		signal_numerique1 : in std_logic_vector(11 downto 0);
		signal_numerique2 : in std_logic_vector(11 downto 0);
		DAC_CLR : out std_logic;
	   DAC_CS : out std_logic;
		SPI_SCK : out std_logic;
		SPI_MOSI : out std_logic
		);
end component;

component master_neurone is
port(
		H 					: In std_logic;
		reset 			: In std_logic;
		reset_2			: In std_logic;--Vmem et tau à 0
		enable 			: In std_logic;
				--test et mesure
		i_stim 			: in std_logic_vector(31 downto 0);
		clamping 		: in std_logic; --'0' : V<= Vmem
		Vclamp 			: in std_logic_vector(15 downto 0);
		mux_mesure1 	: in std_logic_vector(2 downto 0);
		mux_mesure2 	: in std_logic_vector(2 downto 0);
		interrupteur 	: in std_logic_vector(4 downto 0); -- "Na K Ca leak stim"   '0' fermé | '1' ouvert
		
				--paramètres
		delta_t_sur_C : in std_logic_vector(15 downto 0);

		Vequi_Na 		: in std_logic_vector(15 downto 0);
		Vequi_K 			: in std_logic_vector(15 downto 0);
		Vequi_Ca 		: in std_logic_vector(15 downto 0);
		Vequi_leak 		: in std_logic_vector(15 downto 0);

		g_max_Na 		: in std_logic_vector(15 downto 0);
		g_max_K 			: in std_logic_vector(15 downto 0);
		g_max_Ca 		: in std_logic_vector(15 downto 0);
		g_leak 			: in std_logic_vector(15 downto 0);

		p_Na    			: in std_logic_vector(3 downto 0);
		q_Na    			: in std_logic_vector(3 downto 0);
		p_K	   		: in std_logic_vector(3 downto 0);
		p_Ca		   	: in std_logic_vector(3 downto 0);
		q_Ca    			: in std_logic_vector(3 downto 0);
		
		Voffset_a_Na 	: in std_logic_vector(15 downto 0);
	   Voffset_i_Na 	: in std_logic_vector(15 downto 0);
	   Voffset_K    	: in std_logic_vector(15 downto 0);
	   Voffset_a_Ca 	: in std_logic_vector(15 downto 0);
	   Voffset_i_Ca 	: in std_logic_vector(15 downto 0);
	  
		Vpente_a_Na  	: in std_logic_vector(15 downto 0);
	   Vpente_i_Na  	: in std_logic_vector(15 downto 0);
	   Vpente_K     	: in std_logic_vector(15 downto 0);
	   Vpente_a_Ca  	: in std_logic_vector(15 downto 0);
	   Vpente_i_Ca  	: in std_logic_vector(15 downto 0);
		
		reset_lvmem 	: in std_logic;--qd Vslope ou Vmem changent

		accu_max_m_Na 	: in std_logic_vector(19 downto 0);
		accu_max_h_Na 	: in std_logic_vector(19 downto 0);
		accu_max_n_K  	: in std_logic_vector(19 downto 0);
		accu_max_m_Ca 	: in std_logic_vector(19 downto 0);
		accu_max_h_Ca 	: in std_logic_vector(19 downto 0);
		
				--sigmoïd
		data_sigmoid	: in  std_logic_vector(15 downto 0);
		LUT_en 			: In std_logic;
		LUT_rst 			: In std_logic;
		
				--sortie mesures
		mesure1_12bit 	: out std_logic_vector(11 downto 0);
		mesure2_12bit 	: out std_logic_vector(11 downto 0);
		mesure_picob	: out std_logic_vector(223 downto 0);
		
		test_fill : out std_logic
		
);
end component;



begin

		--instanciation
b1 : master_picoblaze
						port map(H,reset,switches,Rx,LED,Tx,parametres,data_sigmoid,lut_en,lut_rst);

b2: interface_SPI_equation
						port map(H,reset,mesure1_12bit,mesure2_12bit,DAC_CLR,DAC_CS,SPI_SCK,SPI_MOSI);
									
b3: master_neurone	
port map(	H,reset,reset_2,enable,
				parametres(503 downto 472),parametres(453),parametres(471 downto 456),
				parametres(510 downto 508),parametres(506 downto 504),parametres(452 downto 448),
				parametres(15 downto 0),
				parametres(95 downto 80),parametres(111 downto 96),parametres(127 downto 112),parametres(143 downto 128),
				parametres(31 downto 16),parametres(47 downto 32),parametres(63 downto 48),parametres(79 downto 64),
				parametres(151 downto 148),parametres(147 downto 144),parametres(159 downto 156),parametres(167 downto 164),parametres(163 downto 160),
				parametres(183 downto 168),parametres(199 downto 184),parametres(215 downto 200),parametres(231 downto 216),parametres(247 downto 232),
				parametres(263 downto 248),parametres(279 downto 264),parametres(295 downto 280),parametres(311 downto 296),parametres(327 downto 312),
				parametres(454),
				parametres(347 downto 328),parametres(371 downto 352),parametres(395 downto 376),parametres(419 downto 400),parametres(443 downto 424),
				data_sigmoid,lut_en,lut_rst,
				mesure1_12bit,mesure2_12bit,open,
				test_fill);
								
								
				--test et enable :
enable<='1';

test1<=reset;
test_lut_en<=lut_en;
test_lut_rst<=lut_rst;

							
end structurelle;
