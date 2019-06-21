----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:50:47 03/24/2007 
-- Design Name: 
-- Module Name:    send115k - Behavioral 
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

entity send115k is
    Port ( clk   : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           wrt   : in  STD_LOGIC;
           dat   : in  STD_LOGIC_VECTOR (7 downto 0);
           TX    : out  STD_LOGIC;
           busy  : out  STD_LOGIC);
end send115k;

architecture Behavioral of send115k is

signal cmpt  : STD_LOGIC_VECTOR (8 downto 0);
signal top   : STD_LOGIC;
signal decal : STD_LOGIC_VECTOR (8 downto 0);
signal nbbits: STD_LOGIC_VECTOR (3 downto 0);

begin

top <= '1' when cmpt="000000" else '0';
TX <= decal(0);
busy <= '0' when nbbits(3 downto 2) ="11" else '1';


process(clk)
begin
	if clk'event and clk='1' then
		if reset='1' then
			cmpt <= "000000000";
		elsif nbbits(3 downto 2)="11" or  cmpt="000000000" then
			cmpt  <= "110110001"; -- 433 car on veut 115,2kbps et 50MHz/115,2kHz=434.0277...
		else                -- donc 434 cycles
			cmpt<=cmpt-1;
		end if;
	end if;
end process;

process (clk)
begin
	if clk'event and clk='1' then
		if reset='1' then
			decal  <= "111111111";
			nbbits <= "1100";
		elsif nbbits(3 downto 2)="11" then
			-- ici on attend des données à envoyer
			if wrt='1' then
				decal <= dat & '0';
				nbbits<= "1001";
			end if;
		
		else
			-- ici on envoie les données
			if top='1' then
				decal<= '1' & decal(8 downto 1);
				nbbits <= nbbits -1;
			end if;
			
		end if;
	end if;
end process;
end Behavioral;

