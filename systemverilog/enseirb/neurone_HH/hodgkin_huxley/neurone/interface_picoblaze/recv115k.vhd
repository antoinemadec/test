----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:08 03/24/2007 
-- Design Name: 
-- Module Name:    recv115k - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity recv115k is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           dat : out  STD_LOGIC_VECTOR (7 downto 0);
           dat_en : out  STD_LOGIC);
end recv115k;

architecture Behavioral of recv115k is

signal decal : STD_LOGIC_VECTOR (6 downto 0);
signal nbbits: STD_LOGIC_VECTOR (3 downto 0);
signal cmpt  : std_logic_vector(8 downto 0);
signal top   : std_logic;
signal rxi   : std_logic;

begin

-- ce process, c'est juste pour prééchantillonner le signal
-- sinon, il n'y a aucune garantie que le délai min. soit respecté
process(clk)
begin
	if clk'event and clk='1' then
		rxi <= rx;
	end if;
end process;

-- un top d'horloge quand elle est à 0
top <= '1' when cmpt="000000" else '0';

-- dans ce process, on fait la synchro du systeme.
-- on envoie les top d'horloge pour la réception série
process(clk)
begin
	if clk'event and clk='1' then
		if reset='1' then
			cmpt <="000000000";
		elsif (nbbits(3 downto 2)="11") or (cmpt="000000000") then
			cmpt<="110110010";  -- 434 car on veut 115,2kbps et 50MHz/115,2kHz=434.0277...
		else                -- donc 435 cycles
			cmpt<=cmpt-1;
		end if;
	end if;
end process;

-- la valeur de sortie est un registre interne.
dat <= rxi & decal;
dat_en <= '1' when top='1' and nbbits="0001" else '0';

-- ici c'est le process de réception a proprement parler
process(clk)
begin
if clk'event and clk='1' then
	if reset='1' then
		nbbits <= "1100";
	elsif nbbits(3 downto 2)="11" then
		-- ici, on attent le bit de start.
		if rxi='0' then
			nbbits <= "1000";
		end if;
	elsif top='1' then
		-- ici, on fait l'acquisition
		decal <= rxi & decal(6 downto 1);
		nbbits <= nbbits -1;
	end if;
end if;
end process;

end Behavioral;