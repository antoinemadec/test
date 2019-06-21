----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:44:03 03/09/2009 
-- Design Name: 
-- Module Name:    master_quenching - Behavioral 
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

entity master_picoblaze is
port(
		clk 			: In std_logic;
		reset			: In std_logic;
		switches 	: In std_logic_vector(3 downto 0);
		Rx 			: in std_logic;
		LED 			: out std_logic_vector(7 downto 0);
		Tx 			: out std_logic;
		parametres	: out std_logic_vector(511 downto 0);
		
		data_sigmoid: out STD_LOGIC_VECTOR (15 downto 0);
      lut_en      : out STD_LOGIC;
      lut_rst     : out STD_LOGIC

);
end master_picoblaze;

architecture structurelle of master_picoblaze is

-- signaux :
signal RAM_dat_in 	: std_logic_vector( 8 DOWNTO 0);
signal RAM_dat_out   : std_logic_vector( 8 DOWNTO 0);
signal RAM_addr      : std_logic_vector(10 DOWNTO 0);
signal RAM_write     : std_logic;

signal port_id       : std_logic_vector( 7 DOWNTO 0);
signal write_strobe  : std_logic;
signal read_strobe   : std_logic;
signal out_port      : std_logic_vector( 7 DOWNTO 0);
signal in_port       : std_logic_vector( 7 DOWNTO 0);
signal interrupt     : std_logic;
signal interrupt_ack : std_logic;

signal p0_in			: std_logic_vector(7 downto 0);

signal in_port_uart			: std_logic_vector(7 downto 0);--signaux d'entrée du picoblaze
signal in_port_g_io			: std_logic_vector(7 downto 0);
signal in_port_ram_mgr		: std_logic_vector(7 downto 0);
signal in_port_arithmodule	: std_logic_vector(7 downto 0);


--déclaration composants
component uart_module is
   port ( clk        : in    std_logic; 
          pblaze_out : in    std_logic_vector (7 downto 0); 
          pblaze_r   : in    std_logic; 
          pblaze_w   : in    std_logic; 
          port_id    : in    std_logic_vector (7 downto 0); 
          reset      : in    std_logic; 
          RX         : in    std_logic; 
          pblaze_in  : out   std_logic_vector (7 downto 0); 
          TX         : out   std_logic);
end component;

component general_io is
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
end component;

component embedded_kcpsm3 IS
  PORT (      port_id       : OUT std_logic_vector( 7 DOWNTO 0);
              write_strobe  : OUT std_logic;
              read_strobe   : OUT std_logic;
              out_port      : OUT std_logic_vector( 7 DOWNTO 0);
              in_port       : IN  std_logic_vector( 7 DOWNTO 0);
              interrupt     : IN  std_logic;
              interrupt_ack : OUT std_logic;
              reset         : IN  std_logic;
              clk           : IN  std_logic;
              RAM_dat_in    : IN  std_logic_vector( 8 DOWNTO 0);
              RAM_dat_out   : OUT std_logic_vector( 8 DOWNTO 0);
              RAM_addr      : IN  std_logic_vector(10 DOWNTO 0);
              RAM_write     : IN  std_logic);
END component;

component code_RAM_mgr is
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
end component;

component parametres_picoblaze is
PORT( 
		H,reset 					: In std_logic;
		Port_Id 					: in std_logic_vector(7 downto 0);
		WE 						: in std_logic;
		data 						: in std_logic_vector(7 downto 0);
		parametres			 	: out std_logic_vector(511 downto 0)
		);
end component;

component arithmodule is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pblaze_out : in  STD_LOGIC_VECTOR (7 downto 0);
           port_id : in  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_in : out  STD_LOGIC_VECTOR (7 downto 0);
           pblaze_r : in  STD_LOGIC;
           pblaze_w : in  STD_LOGIC);
end component;

component sig_filler is
    Port ( clk      : in  STD_LOGIC;
           rst      : in  STD_LOGIC;
           port_id  : in  STD_LOGIC_VECTOR (7 downto 0);
           port_out : in  STD_LOGIC_VECTOR (7 downto 0);
           write_en : in  STD_LOGIC;
           data     : out STD_LOGIC_VECTOR (15 downto 0);
           lut_en   : out STD_LOGIC;
           lut_rst  : out STD_LOGIC);
end component;

--instanciation
begin

in_port<=(in_port_uart or in_port_g_io or in_port_ram_mgr or in_port_arithmodule);--OR

p0_in<="0000" & switches;

b1: uart_module
port map(clk,out_port,read_strobe,write_strobe,port_id,reset,RX,in_port_uart,TX);
									
b2: general_io		
port map(clk,reset,out_port,port_id,in_port_g_io,read_strobe,write_strobe,p0_in,"00000000",LED,open);
									
b3 : embedded_kcpsm3
port map(port_id,write_strobe,read_strobe,out_port,in_port,interrupt,interrupt_ack,reset,clk,RAM_dat_in,RAM_dat_out,RAM_addr,RAM_write);

b4 : code_RAM_mgr
port map (clk,reset,read_strobe,write_strobe,port_id,out_port,in_port_ram_mgr,RAM_addr,RAM_dat_out,RAM_dat_in,RAM_write);

b5 : parametres_picoblaze
port map(clk,reset,port_Id,write_strobe,out_port,parametres);

b6 : arithmodule
port map(clk,reset,out_port,port_id,in_port_arithmodule,read_strobe,write_strobe);

b7 : sig_filler
port map(clk,reset,port_id,out_port,write_strobe,data_sigmoid,lut_en,lut_rst);
					
end structurelle;
