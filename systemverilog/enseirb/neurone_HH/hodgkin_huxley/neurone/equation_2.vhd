library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


----------------------------------------------------------------------------------
-- G=Gmax*(m^p)*(h^q)
----------------------------------------------------------------------------------

entity equation_2 is
--déclaration des I/O de notre boite final
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
end equation_2;


architecture structurelle of equation_2 is
--déclaration signaux nécessaires au branchement des composants
signal 		sig_m_puissance_p,sig_h_puissance_q : std_logic_vector(15 downto 0);
signal 		g_48bit: std_logic_vector(47 downto 0);

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
						port map(Clk,reset,enable,m,p,sig_m_puissance_p);
						
desactivation: puissance			
						port map(Clk,reset,enable,h,q,sig_h_puissance_q);
						

g_48bit<=std_logic_vector(signed(g_max)*signed(sig_m_puissance_p)*signed(sig_h_puissance_q));
g<=g_48bit(45 downto 30);

end structurelle;
