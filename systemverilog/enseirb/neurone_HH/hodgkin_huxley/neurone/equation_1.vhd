-- Module Name:    equation_1 - Behavioral 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


----------------------------------------------------------------------------------
-- V'mem*C=somme(gion(Vmem-Vequi))  --sort mesure1 et 2 pour le DAC ainsi que les 
												--signaux à renvoyer au pbz
----------------------------------------------------------------------------------

entity equation_1 is
	port( H,reset,enable : In std_logic;
		
			clamping 		: in std_logic; -- pour le test
			Vclamp 			: in std_logic_vector(15 downto 0);
			interrupteur 	: in std_logic_vector(4 downto 0); -- Na, K, Ca, leak, stim '0' fermé, '1' ouvert			
			i_stim			: in std_logic_vector(31 downto 0);
		
			mux_mesure1 	: in std_logic_vector(2 downto 0); -- mesures
			mux_mesure2 	: in std_logic_vector(2 downto 0);
			mesure1 			: out std_logic_vector(15 downto 0);
			mesure2			: out std_logic_vector(15 downto 0);
			mesure_picob	: out std_logic_vector(223 downto 0);
		
			delta_t_sur_C 	: in std_logic_vector(15 downto 0); --paramètres
			Vequi_Na 		: in std_logic_vector(15 downto 0);
			Vequi_K 			: in std_logic_vector(15 downto 0);
			Vequi_Ca 		: in std_logic_vector(15 downto 0);
			Vequi_leak 		: in std_logic_vector(15 downto 0);
			
			g_Na 				: in std_logic_vector(15 downto 0); -- conductances
			g_K 				: in std_logic_vector(15 downto 0);
			g_Ca 				: in std_logic_vector(15 downto 0);
			g_leak 			: in std_logic_vector(15 downto 0);

			Vmem_sortie		: out std_logic_vector(15 downto 0) -- Vmem
			);
end equation_1;

architecture structurelle of equation_1 is

signal i_Na,i_K,i_Ca,i_leak : std_logic_vector(31 downto 0);
signal sig_i_Na,sig_i_K,sig_i_Ca,sig_i_leak,sig_i_stim : std_logic_vector(31 downto 0);
signal Vmem : std_logic_vector(15 downto 0);
signal der_Vmem : std_logic_vector(31 downto 0);
signal Vmem_courant : std_logic_vector(15 downto 0);

--déclaration composants
component courant is
PORT( 
		g,Vmem,Vequi: in std_logic_vector(15 downto 0);
		i: out std_logic_vector(31 downto 0)
		);
end component;

component somme_courant is
PORT( 
		H : in std_logic;
		i_Na,i_K,i_Ca,i_leak,i_stim : in std_logic_vector(31 downto 0);	
		der_Vmem : out std_logic_vector(31 downto 0)
		);
end component;

component primitive is
PORT( 
		H,enable,reset : in std_logic;
		der_Vmem : in std_logic_vector(31 downto 0);
		delta_t_sur_C : in std_logic_vector(15 downto 0);
		Vmem: out std_logic_vector(15 downto 0)
		);
end component;

component mux_clamping is
PORT( 
		clamping : in std_logic;
		Vmem,Vclamp: in std_logic_vector(15 downto 0);
		Vmem_courant: out std_logic_vector(15 downto 0)
		);
end component;

component interrupteur_courant is
PORT( 
		interrupteur : in std_logic_vector(4 downto 0);
		i_Na,i_K,i_Ca,i_leak,i_stim : in std_logic_vector(31 downto 0);
		i_Na_out,i_K_out,i_Ca_out,i_leak_out,i_stim_out : out std_logic_vector(31 downto 0)
		);
end component;


--instanciation
begin

canal_Na: courant
						port map(g_Na,Vmem_courant,Vequi_Na,i_Na);
						
canal_K: courant
						port map(g_K,Vmem_courant,Vequi_K,i_K);
						
canal_Ca: courant
						port map(g_Ca,Vmem_courant,Vequi_Ca,i_Ca);
						
canal_de_fuite: courant
						port map(g_leak,Vmem_courant,Vequi_leak,i_leak);
						
sommation: somme_courant			
						port map(H,sig_i_Na,sig_i_K,sig_i_Ca,sig_i_leak,sig_i_stim,der_Vmem);
						
integration: primitive		
						port map(H,enable,reset,der_Vmem,delta_t_sur_C,Vmem);
						
clamp : mux_clamping
						port map(clamping,Vmem,Vclamp,Vmem_courant);
						
inter : interrupteur_courant
						port map(interrupteur,i_Na,i_K,i_Ca,i_leak,i_stim,sig_i_Na,sig_i_K,sig_i_Ca,sig_i_leak,sig_i_stim);
						

process(Vmem,Vclamp,sig_i_Na,sig_i_K,sig_i_Ca,sig_i_leak,sig_i_stim,der_Vmem,mux_mesure1)
	begin
		case mux_mesure1 is
			when "000" 	=> mesure1<=Vmem;
			when "001" 	=> mesure1<=Vclamp;
			when "010" 	=> mesure1<=sig_i_Na(18 downto 3);
			when "011" 	=> mesure1<=sig_i_K(18 downto 3);
			when "100" 	=> mesure1<=sig_i_Ca(18 downto 3);
			when "101" 	=> mesure1<=sig_i_leak(18 downto 3);
			when "110" 	=> mesure1<=sig_i_stim(18 downto 3);
			when "111" 	=> mesure1<=der_Vmem(18 downto 3);--somme courant
			when others => NULL;
		end case;
	end process;
	
process(Vmem,Vclamp,sig_i_Na,sig_i_K,sig_i_Ca,sig_i_leak,sig_i_stim,der_Vmem,mux_mesure2)
	begin
		case mux_mesure2 is
			when "000" 	=> mesure2<=Vmem;
			when "001" 	=> mesure2<=Vclamp;
			when "010" 	=> mesure2<=sig_i_Na(18 downto 3);
			when "011" 	=> mesure2<=sig_i_K(18 downto 3);
			when "100" 	=> mesure2<=sig_i_Ca(18 downto 3);
			when "101" 	=> mesure2<=sig_i_leak(18 downto 3);
			when "110" 	=> mesure2<=sig_i_stim(18 downto 3);
			when "111" 	=> mesure2<=der_Vmem(18 downto 3); --somme courant
			when others => NULL;
		end case;
	end process;

mesure_picob<=Vmem & Vclamp & sig_i_Na & sig_i_K & sig_i_Ca & sig_i_leak & sig_i_stim & der_Vmem;
Vmem_sortie<=Vmem_courant;
end structurelle;
