----------------------------------------------------------------------------------------------------
--intégration par accumulation (pas de mult), on calcul N+1 lorsque l'on a compté accumax coups d'H
----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity primitive3 is
PORT( 
		H,enable,reset : in std_logic;
		der_N : in std_logic_vector(15 downto 0);
		accu_max : in std_logic_vector(19 downto 0);
		N: out std_logic_vector(15 downto 0)
		);
end primitive3;

architecture Behavioral of primitive3 is
type etats IS(somme, accumulation, tempo);
signal etat : etats;
signal N_sig : std_logic_vector(47 downto 0);
signal i : std_logic_vector(19 downto 0);

begin
process(H,reset)
begin
	if reset='1' then
				N_sig<="000000000000000000000000000000000000000000000000";
				i<=accu_max;
				etat<=somme;
	elsif (H' event and H='1')then
		if enable='1' then 
			case etat is
				when somme => 
					N_sig<=std_logic_vector(signed(N_sig)+signed(der_N));
					etat<=accumulation;
					
				when accumulation =>
					if (signed(i)>0) then
						i<=std_logic_vector(signed(i)-1);
						etat<=accumulation;
					else 	i<=std_logic_vector(signed(i)+signed(accu_max)); 
							etat<=tempo;
					end if;
					
				when tempo=> etat<=somme;
				
			end case;
		end if;
	end if;
end process;

N<=N_sig(22 downto 7); -- on laisse 7 = 9bits précision - 2 bit correspondant aux 4 cycle quand accu_max=1;

end Behavioral;

