----------------------------------------------------------------------------------
--clamping='0' : V<=Vmem
--clamping='1' : V<=Vclamping
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity mux_clamping is
PORT( 
		clamping : in std_logic;
		Vmem,Vclamp: in std_logic_vector(15 downto 0);
		Vmem_courant: out std_logic_vector(15 downto 0)
		);
end mux_clamping;


architecture Behavioral of mux_clamping is

begin
process(clamping,Vmem,Vclamp)
	begin
		if clamping='0' then Vmem_courant<=Vmem;
			else Vmem_courant<=Vclamp;
		end if;
	end process;
end Behavioral;

