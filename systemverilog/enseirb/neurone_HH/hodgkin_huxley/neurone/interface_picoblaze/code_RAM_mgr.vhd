----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:29:07 01/06/2009 
-- Design Name: 
-- Module Name:    RAM_mgr - Behavioral 
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

entity code_RAM_mgr is
    Port ( clk   : in  STD_LOGIC;
           reset : in  STD_LOGIC;
-- pblaze signals
           pblaze_r   : in  STD_LOGIC;
           pblaze_w   : in  STD_LOGIC;
           port_id    : in  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_out : in  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_in  : out STD_LOGIC_VECTOR (7 downto 0);
-- RAM signals
           ram_addr  : out  STD_LOGIC_VECTOR (10 downto 0);
           ram_din   : in   STD_LOGIC_VECTOR ( 8 downto 0);
           ram_dout  : out  STD_LOGIC_VECTOR ( 8 downto 0);
           ram_write : out  STD_LOGIC);
end code_RAM_mgr;

architecture Behavioral of code_RAM_mgr is

constant base_addr : std_logic_vector(7 downto 0) := "00001000";

constant addr_lsb  : std_logic_vector(7 downto 0) := "00001000";
constant addr_msb  : std_logic_vector(7 downto 0) := "00001001";
constant data_lsb  : std_logic_vector(7 downto 0) := "00001010";
constant data_msb  : std_logic_vector(7 downto 0) := "00001011";

signal addr_int    : std_logic_vector(10 downto 0);
signal ram_dbuf    : std_logic_vector( 8 downto 0);
signal incaddr     : std_logic;

begin

ram_addr     <= addr_int;

process(port_id, addr_int, ram_dbuf)
begin
case port_id is
  when addr_lsb => pblaze_in <= addr_int(7 downto 0);
  when addr_msb => pblaze_in <= "00000" & addr_int(10 downto 8);
  when data_lsb => pblaze_in <= ram_dbuf(7 downto 0);
  when data_msb => pblaze_in <= "0000000" & ram_dbuf(8);
  when others   => pblaze_in <= "00000000";
end case;
end process;

process(clk)
begin
if clk'event and clk='1' then
  if reset='1' then
    addr_int  <= "00000000000";
    incaddr   <= '0';
  elsif pblaze_w='1' then
    case port_id is
      when addr_lsb   => addr_int( 7 downto 0) <= pblaze_out;
      when addr_msb   => addr_int(10 downto 8) <= pblaze_out(2 downto 0);
      when data_lsb   => ram_write <= '1';
                         ram_dout  <= ram_dbuf(8) & pblaze_out;
      when data_msb   => ram_write <= '1';
                         ram_dout  <= pblaze_out(0) & ram_dbuf(7 downto 0);
                         incaddr <= '1';
      when others     => null;
    end case;
  elsif incaddr = '1' then
    incaddr   <= '0';
    ram_write <= '0';
    addr_int <= addr_int+1;
  else ram_write <= '0';
  end if;
  ram_dbuf <= ram_din;
end if;
end process;

end Behavioral;

