library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


----------------------------------------------------------------------------------
-- G=Gmax*(n^p)
----------------------------------------------------------------------------------

entity equation_2_version_K is
--déclaration des I/O de notre boite final
port(
		Clk 		: In std_logic;
		reset 	: In std_logic;
		enable	: In std_logic;
		n 			: in std_logic_vector(15 downto 0);
		p 			: in std_logic_vector(3 downto 0);
		g_max 	: in std_logic_vector(15 downto 0);
		g 			: out std_logic_vector(15 downto 0)		
		);
end equation_2_version_K;


architecture structurelle of equation_2_version_K is
--déclaration signaux nécessaires au branchement des composants
signal 		sig_n_puissance_p : std_logic_vector(15 downto 0);
signal 		g_32bit: std_logic_vector(31 downto 0);

--déclaration composants
component puissance is
PORT( H,reset,enable: in std_logic;
		n: in std_logic_vector(15 downto 0);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
		p: in std_logic_vector(3 downto 0);
		n_puissance_p : out std_logic_vector(15 downto 0)
		);
end component;

--instanciation
begin


activation: puissance
						port map(Clk,reset,enable,n,p,sig_n_puissance_p);

g_32bit<=std_logic_vector(signed(g_max)*signed(sig_n_puissance_p));
g<=g_32bit(30 downto 15);

end structurelle;
