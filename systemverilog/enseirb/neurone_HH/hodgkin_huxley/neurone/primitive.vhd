----------------------------------------------------------------------------------
--intégration et multiplication par delta_t_sur_C
--delta_t_sur_C=(Tclk/C)/0.9316
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity primitive is
PORT( 
		H,enable,reset : in std_logic;
		der_Vmem : in std_logic_vector(31 downto 0);
		delta_t_sur_C : in std_logic_vector(15 downto 0);
		Vmem: out std_logic_vector(15 downto 0)
		);
end primitive;

architecture Behavioral of primitive is
signal Vmem_sig : std_logic_vector(47 downto 0);
signal produit_48bit : std_logic_vector(47 downto 0);

begin
process(H,reset)
begin
	if reset='1' then
				Vmem_sig<="000000000000000000000000000000000000000000000000";
	elsif (H' event and H='1')then
		if enable='1' then 
			Vmem_sig<=std_logic_vector(signed(Vmem_sig)+signed(produit_48bit));
		end if;
	end if;
end process;

Vmem<=Vmem_sig(46 downto 31); --car les 14 derniers bits de derVmem sont des bits de précision de i
										-- et les 17 autres suivants de Vmem sont de précision
produit_48bit<=std_logic_vector(signed(der_Vmem)*signed(delta_t_sur_C));

end Behavioral;

