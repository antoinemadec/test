library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


----------------------------------------------------------------------------------
--N_inf=1/(1+e(+-(Vmem-Voffset/Vslope)))
----------------------------------------------------------------------------------

entity equation_4 is
--déclaration des I/O de notre boite final
port(
		clk 				: In std_logic;
		reset 			: In std_logic;
		reset_lvmem 	: in std_logic;--qd Vslope ou Vmem changent
		--Vslope et Voffset
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
		data_sigmoid 	: in std_logic_vector(15 downto 0);
		Vmem 				: in std_logic_vector(15 downto 0);
		act_K_inf 		: out std_logic_vector(9 downto 0);
		act_Na_inf 		: out std_logic_vector(9 downto 0);
		act_Ca_inf 		: out std_logic_vector(9 downto 0);
		inact_Na_inf 	: out std_logic_vector(9 downto 0);
		inact_Ca_inf 	: out std_logic_vector(9 downto 0);
		--test
		test_fill : out std_logic;
		remplissage_ram : out std_logic_vector(8 downto 0);
		test_addr : out std_logic_VECTOR(10 downto 0)
		);
end equation_4;


architecture structurelle of equation_4 is
signal douta,doutb : std_logic_vector (8 downto 0);
signal addra,addrb : std_logic_VECTOR(10 downto 0);
signal dina : std_logic_VECTOR(8 downto 0);
signal wea : std_logic;
signal cmpt1,cmpt2 : std_logic_VECTOR(2 downto 0);
signal read_adr : std_logic_VECTOR(10 downto 0);
signal sign1,sign2 : std_logic;

--test
signal sig_test_fill : std_logic;

--déclaration composants

component LUTadr_gen is
    Port ( clk       	: in  STD_LOGIC;
           reset     	: in  STD_LOGIC;
			  reset_lvmem 	: in std_logic;--qd Vslope ou Vmem changent
			  --Vslope et Voffset
           Voffset_a_Na : in std_logic_vector(15 downto 0);
			  Voffset_i_Na : in std_logic_vector(15 downto 0);
			  Voffset_K    : in std_logic_vector(15 downto 0);
			  Voffset_a_Ca : in std_logic_vector(15 downto 0);
			  Voffset_i_Ca : in std_logic_vector(15 downto 0);
			  Vpente_a_Na  : in std_logic_vector(15 downto 0);
			  Vpente_i_Na  : in std_logic_vector(15 downto 0);
			  Vpente_K     : in std_logic_vector(15 downto 0);
			  Vpente_a_Ca  : in std_logic_vector(15 downto 0);
			  Vpente_i_Ca  : in std_logic_vector(15 downto 0);
			  
           Vmem      	: in  STD_LOGIC_VECTOR (15 downto 0);
           adr1      	: out  STD_LOGIC_VECTOR (10 downto 0);
           sign1     	: out  STD_LOGIC;
           cmpt1     	: out STD_LOGIC_VECTOR (2 downto 0);
           adr2      	: out  STD_LOGIC_VECTOR (10 downto 0);
           sign2     	: out  STD_LOGIC;
           cmpt2     	: out STD_LOGIC_VECTOR (2 downto 0));
end component;

component LUT_filler is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           data_sigmoid : in  STD_LOGIC_VECTOR (15 downto 0);
           LUT_en    : in  STD_LOGIC;
           LUT_rst   : in  STD_LOGIC;
           wrt       : out STD_LOGIC;
           adr       : out STD_LOGIC_VECTOR (10 downto 0);
           data      : out STD_LOGIC_VECTOR ( 8 downto 0);
           read_adr  : in  STD_LOGIC_VECTOR (10 downto 0);
			  test_fill : out std_logic);
end component;

component sigmoid_LUT IS
	port (
	addra: IN std_logic_VECTOR(10 downto 0);
	addrb: IN std_logic_VECTOR(10 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(8 downto 0);
	douta: OUT std_logic_VECTOR(8 downto 0);
	doutb: OUT std_logic_VECTOR(8 downto 0);
	wea: IN std_logic);
END component;

component reduct_size is
    Port ( clk    : in  STD_LOGIC;
           entree : in  STD_LOGIC_VECTOR ( 8 downto 0);
           signe  : in  STD_LOGIC;
           cmpt   : in  STD_LOGIC_VECTOR ( 2 downto 0);
           s0     : out STD_LOGIC_VECTOR ( 9 downto 0);
           s1     : out STD_LOGIC_VECTOR ( 9 downto 0);
           s2     : out STD_LOGIC_VECTOR ( 9 downto 0));
end component;

	--test
component test_LUT is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           data_sigmoid : in  STD_LOGIC_VECTOR (15 downto 0);
           LUT_en    : in  STD_LOGIC;
			  test_fill : in std_logic;
			  remplissage_ram : out std_logic_vector(8 downto 0));
end component;


--instanciation
begin

generateur_adresse : LUTadr_gen
			port map (clk,reset,reset_lvmem,
						Voffset_a_Na,Voffset_i_Na,Voffset_K,Voffset_a_Ca,Voffset_i_Ca,
						Vpente_a_Na,Vpente_i_Na,Vpente_K,Vpente_a_Ca,Vpente_i_Ca,
						Vmem,read_adr,sign1,cmpt1,addrb,sign2,cmpt2);
						
remplisseur_ram : LUT_filler
			port map (clk,reset,data_sigmoid,LUT_en,LUT_rst,wea,addra,dina,read_adr,sig_test_fill);
	 
ram : sigmoid_LUT 
			port map (addra,addrb,clk,clk,dina,douta,doutb,wea);
			
mise_forme_1 : reduct_size
			port map (clk,douta,sign1,cmpt1,act_K_inf,act_Na_inf,inact_Na_inf);
			
mise_forme_2 : reduct_size
			port map (clk,doutb,sign2,cmpt2,inact_Ca_inf,act_Ca_inf,open);
	--test--		
test_remplissage : test_LUT
			port map(clk,reset,data_sigmoid,LUT_en,sig_test_fill,remplissage_ram);			
test_fill<=sig_test_fill;
test_addr<=addrb;
end structurelle;
