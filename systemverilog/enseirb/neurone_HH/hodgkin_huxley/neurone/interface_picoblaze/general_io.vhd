----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:59:44 01/06/2009 
-- Design Name: 
-- Module Name:    general_io - Behavioral 
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

entity general_io is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pblaze_out : in  STD_LOGIC_VECTOR (7 downto 0);
           port_id : in  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_in : out  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_r : in  STD_LOGIC;
           pblaze_w : in  STD_LOGIC;
           p0_in : in  STD_LOGIC_VECTOR (7 downto 0);
           p1_in : in  STD_LOGIC_VECTOR (7 downto 0);
           p0_out : out  STD_LOGIC_VECTOR (7 downto 0);
           p1_out : out  STD_LOGIC_VECTOR (7 downto 0));
end general_io;

architecture Behavioral of general_io is

constant p0_addr : std_logic_vector(7 downto 0):= "00000000";
constant p1_addr : std_logic_vector(7 downto 0):= "00000001";

signal p0 : std_logic_vector(7 downto 0);
signal p1 : std_logic_vector(7 downto 0);


begin

p0_out <= p0;
p1_out <= p1;

process(p0_in, p1_in, port_id)
begin
case port_id is
  when p0_addr => pblaze_in <= p0_in;
  when p1_addr => pblaze_in <= p1_in;
  when others  => pblaze_in <= "00000000";
end case;
end process;


process(clk)
begin
if clk'event and clk='1' then
  if reset='1' then
    p0 <= "00000000";
    p1 <= "00000000";
  else
    if port_id=p0_addr and pblaze_w='1' then
      p0 <= pblaze_out;
    end if;
    if port_id=p1_addr and pblaze_w='1' then
      p1 <= pblaze_out;
    end if;
  end if;
end if;
end process;


end Behavioral;