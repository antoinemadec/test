-- Module Name:    master_neurone - Behavioral 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity master_neurone is
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
end master_neurone;

architecture structurelle of master_neurone is
--SIGNAUX :
--branchement
signal mesure1 		: std_logic_vector(15 downto 0);
signal mesure2 		: std_logic_vector(15 downto 0);

signal g_Na 			: std_logic_vector(15 downto 0);
signal g_K 				: std_logic_vector(15 downto 0);
signal g_Ca 			: std_logic_vector(15 downto 0);
signal g_Na_buffer 	: std_logic_vector(15 downto 0);
signal g_K_buffer  	: std_logic_vector(15 downto 0);
signal g_Ca_buffer  	: std_logic_vector(15 downto 0);
signal m_Na 			: std_logic_vector(15 downto 0);
signal h_Na 			: std_logic_vector(15 downto 0);
signal n_K 				: std_logic_vector(15 downto 0);
signal m_Ca 			: std_logic_vector(15 downto 0);
signal h_Ca 			: std_logic_vector(15 downto 0);

signal act_K_inf 		: std_logic_vector(9 downto 0);
signal act_Na_inf 	: std_logic_vector(9 downto 0);
signal act_Ca_inf 	: std_logic_vector(9 downto 0);
signal inact_Na_inf 	: std_logic_vector(9 downto 0);
signal inact_Ca_inf 	: std_logic_vector(9 downto 0);

signal m_Na_inf		: std_logic_vector(15 downto 0);
signal h_Na_inf		: std_logic_vector(15 downto 0);
signal n_K_inf			: std_logic_vector(15 downto 0);
signal m_Ca_inf		: std_logic_vector(15 downto 0);
signal h_Ca_inf 		: std_logic_vector(15 downto 0);

signal Vmem_sortie	: std_logic_vector(15 downto 0);

--test
signal remplissage_ram : std_logic_vector(8 downto 0);
signal test_addr : std_logic_vector(10 downto 0);


--déclaration composants
component equation_1 is 
port(		
		H,reset,enable : In std_logic;
		
		clamping : in std_logic; -- pour le test
		Vclamp : in std_logic_vector(15 downto 0);
		interrupteur : in std_logic_vector(4 downto 0); -- Na, K, Ca, leak, stim '0' fermé, '1' ouvert			
		i_stim: in std_logic_vector(31 downto 0);
	
		mux_mesure1 : in std_logic_vector(2 downto 0); -- mesures
		mux_mesure2 : in std_logic_vector(2 downto 0);
		mesure1 : out std_logic_vector(15 downto 0);
		mesure2: out std_logic_vector(15 downto 0);
		mesure_picob	: out std_logic_vector(223 downto 0);
	
		delta_t_sur_C : in std_logic_vector(15 downto 0); --paramètres
		Vequi_Na : in std_logic_vector(15 downto 0);
		Vequi_K : in std_logic_vector(15 downto 0);
		Vequi_Ca : in std_logic_vector(15 downto 0);
		Vequi_leak : in std_logic_vector(15 downto 0);
		
		g_Na : in std_logic_vector(15 downto 0); -- conductances
		g_K : in std_logic_vector(15 downto 0);
		g_Ca : in std_logic_vector(15 downto 0);
		g_leak : in std_logic_vector(15 downto 0);

		Vmem_sortie		: out std_logic_vector(15 downto 0) -- Vmem		
		);
end component;

component equation_2 is
port(
		Clk 		: In std_logic;
		reset 	: In std_logic;
		enable	: In std_logic;
		m 			: in std_logic_vector(15 downto 0);
		h 			: in std_logic_vector(15 downto 0);
		p 			: in std_logic_vector(3 downto 0);
		q 			: in std_logic_vector(3 downto 0);
		g_max 	: in std_logic_vector(15 downto 0);
		g 			: out std_logic_vector(15 downto 0)		
		);
end component;

component equation_2_version_K is
port(
		Clk 		: In std_logic;
		reset 	: In std_logic;
		enable	: In std_logic;
		n 			: in std_logic_vector(15 downto 0);
		p 			: in std_logic_vector(3 downto 0);
		g_max 	: in std_logic_vector(15 downto 0);
		g 			: out std_logic_vector(15 downto 0)		
		);
end component;

component equation_3 is
port(
		H 			: In std_logic;
		reset 	: In std_logic;
		enable 	: In std_logic;
		accu_max	: in std_logic_vector(19 downto 0);
		N_inf 	: in std_logic_vector(15 downto 0);
		N 			: out std_logic_vector(15 downto 0)		
		);
end component;

component equation_4 is
port(
		clk 				: In std_logic;
		reset 			: In std_logic;
		reset_lvmem 	: in std_logic;
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
		LUT_en 			: In std_logic;
		LUT_rst 			: In std_logic;
		data_sigmoid	: in std_logic_vector(15 downto 0);
		Vmem 				: in std_logic_vector(15 downto 0);
		act_K_inf 		: out std_logic_vector(9 downto 0);
		act_Na_inf 		: out std_logic_vector(9 downto 0);
		act_Ca_inf 		: out std_logic_vector(9 downto 0);
		inact_Na_inf 	: out std_logic_vector(9 downto 0);
		inact_Ca_inf 	: out std_logic_vector(9 downto 0);
		--test--
		test_fill : out std_logic;
		remplissage_ram : out std_logic_vector(8 downto 0);
		test_addr : out std_logic_VECTOR(10 downto 0)
		);
end component;

component buffer_g is
PORT( 
		H			: In std_logic;
		g_in_Na	: in std_logic_vector(15 downto 0);
		g_in_K	: in std_logic_vector(15 downto 0);	
		g_in_Ca	: in std_logic_vector(15 downto 0);			
		g_out_Na	: out std_logic_vector(15 downto 0);
		g_out_K	: out std_logic_vector(15 downto 0);
		g_out_Ca	: out std_logic_vector(15 downto 0)
		);
end component;

--instanciation
begin

mesure1_12bit<=std_logic_vector(unsigned(mesure1(15 downto 4))+"100000000000");

--mesure2_12bit<=std_logic_vector(unsigned(mesure2(15 downto 4))+"100000000000");
--mesure2_12bit<=act_Ca_inf&"00";
--mesure2_12bit<=remplissage_ram&"000";
mesure2_12bit<=test_addr&"0";--addrb
								
m_Na_inf <= '0' & act_Na_inf & "11111";
h_Na_inf	<= '0' & inact_Na_inf & "11111";
n_K_inf	<= '0' & act_K_inf & "11111";
m_Ca_inf	<= '0' & act_Ca_inf & "11111";
h_Ca_inf <= '0' & inact_Ca_inf & "11111";
--m_Na_inf <= "0111111111111111";
--h_Na_inf	<= "0111111111111111";
--n_K_inf	<= "0111111111111111";
--m_Ca_inf	<= "0111111111111111";
--h_Ca_inf <= "0111111111111111";

branchement : equation_1		
						port map(H,reset_2,enable,clamping,Vclamp,interrupteur,i_stim,mux_mesure1,mux_mesure2,mesure1,mesure2,mesure_picob,delta_t_sur_C,Vequi_Na,Vequi_K,Vequi_Ca,Vequi_leak,g_Na_buffer,g_K_buffer,g_Ca_buffer,g_leak);

g_buffer_Na_K_Ca : buffer_g
						port map(H,g_Na,g_K,g_Ca,g_Na_buffer,g_K_buffer,g_Ca_buffer);
						
Na_g : equation_2 
						port map(H,reset,enable,m_Na,h_Na,p_Na,q_Na,g_max_Na,g_Na);

Na_m : equation_3
						port map(H,reset_2,enable,accu_max_m_Na,m_Na_inf,m_Na);
												
Na_h : equation_3
						port map(H,reset_2,enable,accu_max_h_Na,h_Na_inf,h_Na);
						
K_g : equation_2_version_K 
						port map(H,reset,enable,n_K,p_K,g_max_K,g_K);
						
K_n : equation_3
						port map(H,reset_2,enable,accu_max_n_K,n_K_inf,n_K);
						
Ca_g : equation_2 
						port map(H,reset,enable,m_Ca,h_Ca,p_Ca,q_Ca,g_max_Ca,g_Ca);
						
Ca_m : equation_3
						port map(H,reset_2,enable,accu_max_m_Ca,m_Ca_inf,m_Ca);
						
Ca_h : equation_3
						port map(H,reset_2,enable,accu_max_h_Ca,h_Ca_inf,h_Ca);
						
calcul_cinetiques_inf : equation_4
						port map(H,reset,reset_lvmem,
									Voffset_a_Na,Voffset_i_Na,Voffset_K,Voffset_a_Ca,Voffset_i_Ca,
									Vpente_a_Na,Vpente_i_Na,Vpente_K,Vpente_a_Ca,Vpente_i_Ca,
									LUT_en,LUT_rst,data_sigmoid,Vmem_sortie,
									act_K_inf,act_Na_inf,act_Ca_inf,
									inact_Na_inf,inact_Ca_inf,
									--test
									test_fill,remplissage_ram,test_addr
									);							
end structurelle;