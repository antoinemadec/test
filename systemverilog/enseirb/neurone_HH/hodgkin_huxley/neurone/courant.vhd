-- g : unsigned de 16 bits (premier bit à 0)
-- Vmem : signed sur 16 bits
-- V equi : signed sur 16 bits
--  i : signed sur 32 bits   i=g(Vmem-Vequi)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity courant is
PORT( 
		g,Vmem,Vequi: in std_logic_vector(15 downto 0);
		i: out std_logic_vector(31 downto 0)
		);
end courant;


architecture Behavioral of courant is

signal difference : std_logic_vector(15 downto 0);

begin
difference<=std_logic_vector(signed(Vequi)-signed(Vmem));
i<=std_logic_vector(signed(g)*signed(difference));--2bits don't care // 16 bits iLSB=82pA // 14bits précision

end Behavioral;

