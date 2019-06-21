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
		signal_numerique : out std_logic_vector(7 downto 0);
		test1,test2 : out std_logic
		);
end generateur_sinus_racine2sur2;

architecture Behavioral of generateur_sinus_racine2sur2 is

--------------------------------------------------------
constant n: integer := 6; -- 1/delta_t = 2^n   n= 6 ou 7
--------------------------------------------------------

type etats IS(calcul_Dnp1,test_racine2sur2,calcul_Pnp2,calcul_nouvelles_valeurs);
signal Dn,Dnp1,D2n: signed (15 downto 0);-- 17 = 8 + 9 fract
signal Pn,Pnp1,Pnp2 : signed (15 downto 0);
signal difference : signed (15 downto 0);
signal signe_D2n : signed (15 downto 0);
signal signe_Dnp1 : signed (15 downto 0);
signal zeros : signed (15 downto 0):="0000000000000000";
Signal etat : etats;

begin

process(H,reset) --Partie compteur--
		  
Begin
--reset asynchrone
		if reset='1' then
				Pn<="0000000000000000";
				Pnp1<="0000000100000000";
						--calcul de D0 = (P1 - P0)*(1/delta_t)
				if n>0 then
							Dn<=(difference((15-n) downto 0) & zeros((n-1) downto 0));
							else Dn<=difference;
						end if;
				etat<=calcul_Dnp1;
		
		elsif (H' event and H='1') then
			if enable='1' then
				case etat is 
		
					when calcul_Dnp1 => --Dn+1 = D2n/(1/delta_t) + Dn     
						if n>0 then
							Dnp1<=(signe_D2n((n-1) downto 0) & D2n(15 downto n)) + Dn;
							else Dnp1<=Dn + D2n;
						end if;
						etat<=calcul_Pnp2;
						
					when calcul_Pnp2 => --Pn+2 = Dn+1/(1/delta_t) + Pn+1
						if n>0 then
							Pnp2<=(signe_Dnp1((n-1) downto 0) & Dnp1(15 downto n)) + Pnp1;
							else Pnp2<=Dnp1 + Pnp1;
						end if;
						etat<=calcul_nouvelles_valeurs;
						
					when calcul_nouvelles_valeurs =>
						Pn<=Pnp1;
						Pnp1<=Pnp2;
						Dn<=Dnp1;
						etat<=test_racine2sur2;
						
					when test_racine2sur2 => 
						--impose la dérivée pour racine(2)/2, pour éviter la divergence
						if Dn>0 then
							if Pn(15 downto 8)=-45 or Pn(15 downto 8)=45
								then 	Dn<=to_signed(11585,16);
										test1<='1';								
								end if;
						else 
							if Pn(15 downto 8)=-45 or Pn(15 downto 8)=45
								then 	Dn<=to_signed(-11585,16);
										test1<='0';
								end if;
						end if;
						--test si on a bien 1 lsb de précision
						if (Pnp1(15 downto 8)-Pn(15 downto 8)>1 or Pnp1(15 downto 8)-Pn(15 downto 8)<-1)then
						test2<='1';
						else test2<='0';
						end if;
						etat<=calcul_Dnp1;
						
				end case;
			end if;
		end if;
end process;

signal_numerique <= std_logic_vector(Pnp1(15 downto 8)+ 128);
D2n<=-Pn;
difference<=(Pnp1-Pn);
signe_D2n<=D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15)&D2n(15);
signe_Dnp1<=Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15)&Dnp1(15);
end Behavioral;

