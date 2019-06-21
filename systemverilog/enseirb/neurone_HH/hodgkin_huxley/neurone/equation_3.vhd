library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

----------------------------------------------------------------------------------
-- N'*tau=Ninf-N    -- tau(ms)=0.00256(3+(accu_max/decrement))
----------------------------------------------------------------------------------

entity equation_3 is
--déclaration des I/O de notre boite final
port(
		H 			: In std_logic;
		reset 	: In std_logic;
		enable 	: In std_logic;
		accu_max	: in std_logic_vector(19 downto 0);
		N_inf 	: in std_logic_vector(15 downto 0);
		N 			: out std_logic_vector(15 downto 0)		
		);
end equation_3;


architecture structurelle of equation_3 is
signal der_N : std_logic_vector (15 downto 0);
signal signal_N : std_logic_vector (15 downto 0);

--déclaration composants

component primitive3 is
PORT( 
		H,enable,reset : in std_logic;
		der_N : in std_logic_vector(15 downto 0);
		accu_max : in std_logic_vector(19 downto 0);
		N: out std_logic_vector(15 downto 0)
		);
end component;

component soustraction3 is
port(
		N_inf,N : in std_logic_vector(15 downto 0);
		der_N : out std_logic_vector(15 downto 0)		
		);
end component;


--instanciation
begin

difference : soustraction3
						port map(N_inf,signal_N,der_N);
						
integration: primitive3		
						port map(H,enable,reset,der_N,accu_max,signal_N);

N<=signal_N;

end structurelle;
