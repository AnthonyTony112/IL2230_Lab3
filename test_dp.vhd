LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.ALL;
USE IEEE.FIXED_PKG.ALL;
library modelsim_lib;
use modelsim_lib.util.all;      
use work.CoeffPak.all;

entity test is
end test;


Architecture test_dp of test is
  
component datapath is
generic (
    M: integer ;
		N: integer ;
		int_bit: integer;
		float_bit: integer
	);
 port (CIN:     In DataArray; --input
      MLP_in:   In DataArray; --single_layer_out
      clk,reset:      In std_logic;
      latency:  In integer;                             --layer_latency
      COUT:     Out DataArray;--out
      Mlp_out:  Out DataArray;--X
      addr:     Out std_logic_vector(7 downto 0);       --address
      lat_count:Out integer                             --latency_counter    
     
-- Reluout: Out sfixed (int_bit-1 downto -float_bit);
--		sigout: Out sfixed (int_bit-1 downto -float_bit)
      );
end component;

signal clk: std_logic:='0';
signal Input:DataArray:=("00100000","00110000","01000000");
signal mlp: DataArray:=("00100000","00110000","01000000");
signal cout,mlp_out: DataArray;
signal reset:std_logic;
signal addr: std_logic_vector(7 downto 0);
signal lat_count: integer;

begin
  reset <='0';
  clk<=not(clk) after 5ns;
  mlp(0)<=mlp(1) after 9 ns;
  mlp(1)<=mlp(2) after 10ns;
  mlp(2)<=resize((mlp(2)+mlp(1)),mlp(2)) after 11 ns;
 test_1:datapath
 generic map(3,2,3,5)
 port map (input,mlp,clk,reset,1,cout,mlp_out,addr,lat_count);
end test_dp;