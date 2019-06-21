----------------------------------------------------------------------------------
-- Company: IMS
-- Engineer: MADEC Antoine
-- 
-- Create Date:    10:48:45 03/09/2009 
-- Design Name: 
-- Module Name:    generateur_rampe - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity generateur_sinus_racine2sur2 is
PORT( 
		H,enable, reset: In std_logic;
		signal_numerique : out std_logic_vector(11 downto 0);
		test1,test2 : out std_logic
		);
end generateur_sinus_racine2sur2;

architecture Behavioral of generateur_sinus_racine2sur2 is

--------------------------------------------------------
constant n: integer := 10; -- 1/delta_t = 2^n       fonctionne pour 10=<n<=11 , plus n petit, plus F grand
--------------------------------------------------------

type etats IS(calcul_Dnp1,test_racine2sur2,calcul_Pnp2,calcul_nouvelles_valeurs);
signal Dn,Dnp1,D2n: signed (23 downto 0);
signal Pn,Pnp1,Pnp2 : signed (23 downto 0);
signal difference : signed (23 downto 0);
signal signe_D2n : signed (23 downto 0);
signal signe_Dnp1 : signed (23 downto 0);
signal zeros : signed (23 downto 0):="000000000000000000000000";
Signal etat : etats;

begin

process(H,reset) --Partie compteur--
		  
Begin
--reset asynchrone
		if reset='1' then
				Pn<="000000000000000000000000";
				Pnp1<="000000000001000000000000";
						--calcul de D0 = (P1 - P0)*(1/delta_t)
				if n>0 then
							Dn<=(difference((23-n) downto 0) & zeros((n-1) downto 0));
							else Dn<=difference;
						end if;
				etat<=calcul_Dnp1;
		
		elsif (H' event and H='1') then
			if enable='1' then
				case etat is 
		
					when calcul_Dnp1 => --Dn+1 = D2n/(1/delta_t) + Dn     
						if n>0 then
							Dnp1<=(signe_D2n((n-1) downto 0) & D2n(23 downto n)) + Dn;
							else Dnp1<=Dn + D2n;
						end if;
						etat<=calcul_Pnp2;
						
					when calcul_Pnp2 => --Pn+2 = Dn+1/(1/delta_t) + Pn+1
						if n>0 then
							Pnp2<=(signe_Dnp1((n-1) downto 0) & Dnp1(23 downto n)) + Pnp1;
							else Pnp2<=Dnp1 + Pnp1;
						end if;
						etat<=calcul_nouvelles_valeurs;
						
					when calcul_nouvelles_valeurs =>
						Pn<=Pnp1;
						Pnp1<=Pnp2;
						Dn<=Dnp1;
						etat<=test_racine2sur2;
						
					when test_racine2sur2 => 
						--test Pn et impose la d�riv�e pour racine(2)/2, pour �viter la divergence
						if Dn>0 then
							if Pn(23 downto 12)=-724 or Pn(23 downto 12)=724
								then Dn<=to_signed(2965821,24); test1<='1';end if;
						else 
							if Pn(23 downto 12)=-724 or Pn(23 downto 12)=724
								then Dn<=to_signed(-2965821,24); test1<='1';end if;
						end if;
						--test si on a bien 1 lsb de pr�cision
						if (Pnp1(23 downto 12)-Pn(23 downto 12)>1 or Pnp1(23 downto 12)-Pn(23 downto 12)<-1)then
						test2<='1';
						else test2<='0';
						end if;
						etat<=calcul_Dnp1;
						
				end case;
			end if;
		end if;
end process;

signal_numerique <= std_logic_vector(Pn(23 downto 12)+ 2048);

D2n<=-Pn;
difference<=(Pnp1-Pn);
signe_D2n<=D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23)&D2n(23);
signe_Dnp1<=Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23)&Dnp1(23);
end Behavioral;

