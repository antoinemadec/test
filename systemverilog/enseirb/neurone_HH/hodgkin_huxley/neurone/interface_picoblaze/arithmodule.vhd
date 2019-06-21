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

entity arithmodule is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pblaze_out : in  STD_LOGIC_VECTOR (7 downto 0);
           port_id : in  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_in : out  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_r : in  STD_LOGIC;
           pblaze_w : in  STD_LOGIC);
end arithmodule;

architecture Behavioral of arithmodule is

constant base_addr : std_logic_vector(7 downto 0):= "00010000";

constant hex2bin   : std_logic_vector(7 downto 0):= "00010000";
constant bin2hex   : std_logic_vector(7 downto 0):= "00010001";
constant quartl_cb : std_logic_vector(7 downto 0):= "00010010";
constant quartm_sw : std_logic_vector(7 downto 0):= "00010011";
constant multa_lsb : std_logic_vector(7 downto 0):= "00010100";
constant multa_msb : std_logic_vector(7 downto 0):= "00010101";
constant multb_lsb : std_logic_vector(7 downto 0):= "00010110";
constant multb_msb : std_logic_vector(7 downto 0):= "00010111";
constant decal_val : std_logic_vector(7 downto 0):= "00011000";
constant decal_n   : std_logic_vector(7 downto 0):= "00011001";


signal hexbin : std_logic_vector( 3 downto 0);
signal quartm : std_logic_vector( 3 downto 0);
signal quartl : std_logic_vector( 3 downto 0);
signal multa  : std_logic_vector(15 downto 0);
signal multb  : std_logic_vector(15 downto 0);
signal multr  : std_logic_vector(31 downto 0);
signal decalv : std_logic_vector( 7 downto 0);
signal decaln : std_logic_vector( 2 downto 0);
signal decalr : std_logic_vector(15 downto 0);

begin


process(port_id, hexbin, quartl, quartm, multr)
begin
  case port_id is
    when hex2bin   => pblaze_in <= "0000" & hexbin;
    when bin2hex   => if hexbin < "1010" then pblaze_in <= "0011" & hexbin;
                                         else pblaze_in <= "00110111" + ("0000" & hexbin);
                      end if;
    when quartl_cb => pblaze_in <= quartm & quartl;
    when quartm_sw => pblaze_in <= quartm & quartl;
    when multa_lsb => pblaze_in <=  multr( 7 downto  0);
    when multa_msb => pblaze_in <=  multr(15 downto  8);
    when multb_lsb => pblaze_in <=  multr(23 downto 16);
    when multb_msb => pblaze_in <=  multr(31 downto 24);
    when decal_val => pblaze_in <= decalr( 7 downto  0);
    when decal_n   => pblaze_in <= decalr(15 downto  8);
    when others    => pblaze_in <= "00000000";
  end case;
end process;






process(clk)
begin
if clk'event and clk='1' then
  if reset='1' then
    hexbin <= "0000";
    quartm <= "0000";
    quartl <= "0000";
    multa  <= "0000000000000000";
    multb  <= "0000000000000000";
    multr  <= "00000000000000000000000000000000"; 
    decalv <= "00000000";
    decaln <= "000";
  elsif pblaze_w = '1' then
    if port_id=hex2bin then
      if pblaze_out(6)='0' then
        hexbin <= pblaze_out(3 downto 0);
      else
        hexbin <= pblaze_out(3 downto 0) + "1001";
      end if;
    elsif port_id=bin2hex then
      hexbin <= pblaze_out(3 downto 0);
    end if;
    
    if    port_id=quartl_cb then quartl <= pblaze_out(3 downto 0); 
    elsif port_id=quartm_sw then quartm <= pblaze_out(3 downto 0);
                                 quartl <= pblaze_out(7 downto 4);
    end if;
    
    case port_id is
      when multa_lsb => multa( 7 downto 0) <= pblaze_out;
      when multa_msb => multa(15 downto 8) <= pblaze_out;
      when multb_lsb => multa( 7 downto 0) <= pblaze_out;
      when multb_msb => multa(15 downto 8) <= pblaze_out;
      when decal_val => decalv             <= pblaze_out;
      when decal_n   => decaln             <= pblaze_out(2 downto 0);
      when others    => null;
    end case;    
    
    
    
    multr <= multa * multb;
  end if;
end if;
end process;

process(decaln, decalv)
begin
case decaln is
  when "000"  => decalr <= "00000000" & decalv;
  when "001"  => decalr <=  "0000000" & decalv & "0";
  when "010"  => decalr <=   "000000" & decalv & "00";
  when "011"  => decalr <=    "00000" & decalv & "000";
  when "100"  => decalr <=     "0000" & decalv & "0000";
  when "101"  => decalr <=      "000" & decalv & "00000";
  when "110"  => decalr <=       "00" & decalv & "000000";
  when others => decalr <=        "0" & decalv & "0000000";
end case;
end process;


end Behavioral;