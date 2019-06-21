----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:53 01/28/2008 
-- Design Name: 
-- Module Name:    LUTadr_gen - Behavioral 
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

------------------------------------------------------------
--La ram utilisée est une IP Xilinx : Dual block memory V6.3
------------------------------------------------------------

entity LUTadr_gen is
    Port ( clk       	: in  STD_LOGIC;
           reset     	: in  STD_LOGIC;
			  reset_lvmem 	: in std_logic;--qd Vslope ou Vmem changent
			  --Vslope et Voffset
           Voffset_a_Na : in std_logic_vector(15 downto 0);
			  Voffset_i_Na : in std_logic_vector(15 downto 0);
			  Voffset_K    : in std_logic_vector(15 downto 0);
			  Voffset_a_Ca : in std_logic_vector(15 downto 0);
			  Voffset_i_Ca : in std_logic_vector(15 downto 0);
			  Vpente_a_Na  : in std_logic_vector(15 downto 0);
			  Vpente_i_Na  : in std_logic_vector(15 downto 0);
			  Vpente_K     : in std_logic_vector(15 downto 0);
			  Vpente_a_Ca  : in std_logic_vector(15 downto 0);
			  Vpente_i_Ca  : in std_logic_vector(15 downto 0);
			  
           Vmem      	: in  STD_LOGIC_VECTOR (15 downto 0);
           adr1      	: out  STD_LOGIC_VECTOR (10 downto 0);
           sign1     	: out  STD_LOGIC;
           cmpt1     	: out STD_LOGIC_VECTOR (2 downto 0);
           adr2      	: out  STD_LOGIC_VECTOR (10 downto 0);
           sign2     	: out  STD_LOGIC;
           cmpt2     	: out STD_LOGIC_VECTOR (2 downto 0));
end LUTadr_gen;

architecture Behavioral of LUTadr_gen is

signal loc_vmem     : std_logic_vector(15 downto 0);
signal diff_vmem    : std_logic_vector(15 downto 0);


signal adr_a_Na     : std_logic_vector(27 downto 0);
signal adr_i_Na     : std_logic_vector(27 downto 0);
signal adr_K        : std_logic_vector(27 downto 0);
signal adr_a_Ca     : std_logic_vector(27 downto 0);
signal adr_i_Ca     : std_logic_vector(27 downto 0);

signal cmpt_adr1    : std_logic_vector( 2 downto 0);
signal cmpt_adr2    : std_logic_vector( 2 downto 0);
signal pip1_adr1    : std_logic_vector(15 downto 0);
signal pip1_adr2    : std_logic_vector(15 downto 0);
signal pip2_adr1    : std_logic_vector(15 downto 0);
signal pip2_adr2    : std_logic_vector(15 downto 0);
signal psign1       : std_logic;
signal psign2       : std_logic;


begin


diff_vmem <= Vmem - loc_vmem;

cmpt1 <= cmpt_adr1;
cmpt2 <= cmpt_adr2;

--process(clk)
--begin
--if clk'event and clk='1' then
--  if reset='1' then
--    Voffset_a_Na <= "0000000000000000";
--    Voffset_i_Na <= "0000000000000000";
--    Voffset_a_Ca <= "0000000000000000";
--    Voffset_i_Ca <= "0000000000000000";
--    Voffset_K    <= "0000000000000000";
--    Vpente_a_Na  <= "0000000000000000";
--    Vpente_i_Na  <= "0000000000000000";
--    Vpente_a_Ca  <= "0000000000000000";
--    Vpente_i_Ca  <= "0000000000000000";
--    Vpente_K     <= "0000000000000000";
--    reset_lvmem <= '0';
--  elsif param_en='1' and param_num(7 downto 5)="000" then
--    case param_num(4 downto 0) is
--      when "00101" => Vpente_a_Na  <= param_val; reset_lvmem <= '1';
--      when "00110" => Voffset_a_Na <= param_val; reset_lvmem <= '0';
--      when "01000" => Vpente_i_Na  <= param_val; reset_lvmem <= '1';
--      when "01001" => Voffset_i_Na <= param_val; reset_lvmem <= '0';
--      when "01101" => Vpente_K     <= param_val; reset_lvmem <= '1';
--      when "01110" => Voffset_K    <= param_val; reset_lvmem <= '0';
--      when "10010" => Vpente_a_Ca  <= param_val; reset_lvmem <= '1';
--      when "10011" => Voffset_a_Ca <= param_val; reset_lvmem <= '0';
--      when "10101" => Vpente_i_Ca  <= param_val; reset_lvmem <= '1';
--      when "10110" => Voffset_i_Ca <= param_val; reset_lvmem <= '0';
--      when others  => reset_lvmem <= '0';
--    end case;
--  else
--    reset_lvmem <= '0';
--  end if;
--end if;
--end process;

process(clk)
begin
if clk'event and clk='1' then
  if reset='1' or reset_lvmem='1' then
    loc_Vmem <= "0000000000000000";
    adr_a_Na <= "0000000000000000000000000000";
    adr_i_Na <= "0000000000000000000000000000";
    adr_K    <= "0000000000000000000000000000";
    adr_a_Ca <= "0000000000000000000000000000";
    adr_i_Ca <= "0000000000000000000000000000";
  elsif loc_vmem /= Vmem then
    if diff_vmem(15)='1' then -- Vpente est forcement positif...
      loc_vmem <= loc_vmem - 1;
      adr_a_Na <= adr_a_Na - ("000000000000" & Vpente_a_Na);
      adr_i_Na <= adr_i_Na + ("000000000000" & Vpente_i_Na);
      adr_K    <= adr_K    - ("000000000000" & Vpente_K);
      adr_a_Ca <= adr_a_Ca - ("000000000000" & Vpente_a_Ca);
      adr_i_Ca <= adr_i_Ca + ("000000000000" & Vpente_i_Ca);
    else
      loc_vmem <= loc_vmem + 1;
      adr_a_Na <= adr_a_Na + ("000000000000" & Vpente_a_Na);
      adr_i_Na <= adr_i_Na - ("000000000000" & Vpente_i_Na);
      adr_K    <= adr_K    + ("000000000000" & Vpente_K);
      adr_a_Ca <= adr_a_Ca + ("000000000000" & Vpente_a_Ca);
      adr_i_Ca <= adr_i_Ca - ("000000000000" & Vpente_i_Ca);
    end if;
  end if;
end if;
end process;

process(clk)
begin
if clk'event and clk='1' then
  if reset = '1' then
    cmpt_adr1 <= "010";
    cmpt_adr2 <= "001";
  else
    if cmpt_adr1="000" then
      cmpt_adr1 <= "010";
    else
      cmpt_adr1 <= cmpt_adr1 - 1;
    end if;
    
    if cmpt_adr2="000" then
      cmpt_adr2 <= "001";
    else
      cmpt_adr2 <= cmpt_adr2 - 1;
    end if;

  end if;
end if;
end process;



process(clk)
begin
if clk'event and clk='1' then
  case cmpt_adr1 is
    when "000" =>  pip1_adr1 <= adr_a_Na(27 downto 12) - Voffset_a_Na;
    when "001" =>  pip1_adr1 <= adr_i_Na(27 downto 12) + Voffset_i_Na;
    when others => pip1_adr1 <= adr_K (27 downto 12)   - Voffset_K;
  end case;
  
  psign1 <= pip1_adr1(15);
  if pip1_adr1(15) = '1' then
    pip2_adr1  <= not pip1_adr1;
  else
    pip2_adr1  <= pip1_adr1;
  end if;
  
  sign1 <= psign1;
  if pip2_adr1(15 downto 12) = "0000" then
    adr1 <= pip2_adr1(11 downto 1);
  else
    adr1 <= "11111111111";
  end if;
end if;
end process;


process(clk)
begin
if clk'event and clk='1' then
  case cmpt_adr2 is
    when "000" =>  pip1_adr2 <= adr_a_Ca(27 downto 12) - Voffset_a_Ca;
    when others => pip1_adr2 <= adr_i_Ca(27 downto 12) + Voffset_i_Ca;
  end case;
  
  psign2 <= pip1_adr2(15);
  if pip1_adr2(15) = '1' then
    pip2_adr2  <= not pip1_adr2;
  else
    pip2_adr2  <= pip1_adr2;
  end if;
  
  sign2 <= psign2;
  if pip2_adr2(15 downto 12) = "0000" then
    adr2 <= pip2_adr2(11 downto 1);
  else
    adr2 <= "11111111111";
  end if;
end if;
end process;


end Behavioral;