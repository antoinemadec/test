------------------------------------------------------------
--calcul n^p
------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity puissance is
PORT( H,reset,enable: in std_logic;
		n: in std_logic_vector(15 downto 0);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
		p: in std_logic_vector(3 downto 0);
		n_puissance_p : out std_logic_vector(15 downto 0)
		);
end puissance;

architecture Behavioral of puissance is
type etats IS( init,incrementation);
signal etat : etats;
signal sig_n_puissance_p : std_logic_vector(31 downto 0);
signal multiplication : std_logic_vector(31 downto 0);
signal sig_p : std_logic_vector(3 downto 0);

BEGIN

process(H)
begin
	if (H' event and H='1') then
		if reset='1' then
			n_puissance_p<=n;
			etat<=init;
			
		elsif enable='1' then
			case etat is
				when init =>
						if (signed(p)<1) then -- si la puissance vaut 0 ou moins
								n_puissance_p<="0111111111111111";
								sig_n_puissance_p<="0000000000000000"&"0111111111111111";--pour ne pas avoir de sig_n_puissance_p undefined
						else
								n_puissance_p<=sig_n_puissance_p(31 downto 16);
								sig_p<=std_logic_vector(signed(p)-"0001");
								sig_n_puissance_p<=n&"0000000000000000";
								etat<=incrementation;
						end if;
						
				when incrementation =>
								if signed(sig_p)>0 then
									sig_n_puissance_p<=multiplication(30 downto 0)&'0';
									sig_p<=std_logic_vector(signed(sig_p)-"0001");
								else etat<=init;
								end if;
			end case;
		end if;
	end if;
end process;

multiplication<=std_logic_vector(signed(n)*signed(sig_n_puissance_p(31 downto 16)));

end Behavioral;

