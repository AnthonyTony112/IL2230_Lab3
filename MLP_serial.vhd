library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";
use work.all;
use ieee.fixed_pkg.all;
use work.CoeffPak.all;

entity MLP_serial is
generic (
		N: integer := 3;
		int_bit: integer :=3;
		float_bit: integer :=5
	);
port (
X: In DataArray:=(others=>(others=>'0'));
b: In sfixed(int_bit-1 downto -float_bit);
clk,reset: in std_logic;
L_Latency: in integer;
Output: out DataArray);
end MLP_serial;

architecture structure of MLP_serial is

signal La_Counter: integer;
signal X_in: DataArray:=(others=>(others=>'0'));
signal layer_out: DataArray;
signal W_in: DataArray2D:=(others=>(others=>(others=>'0')));
signal W_addr: std_logic_vector(7 downto 0);
signal new_lay_out: std_logic;
begin
datapath_1: entity work.datapath(structure)
generic map(M, N, int_bit, float_bit)
port map(
      CIN => X,
      MLP_in => layer_out,
      clk => clk,
      latency => L_Latency,                        
      COUT => Output,    
      Mlp_out => X_in,
      addr => W_addr,
      lat_count => La_Counter,
      reset => reset   
);

serial_layer_1: entity work.serial_layer(structure)
generic map(N, int_bit, float_bit)
port map( 
X => X_in,
W => W_in,
b => b,
LCounter => La_Counter,
reset => reset,
clk => clk,
Result => layer_out,
new_result => new_lay_out-------------------------------------
); 

ROM_1: entity work.ROM(behave)
generic map(N, M,int_bit, float_bit)
port map (
     addr => W_addr,
     clk => clk,
     W => W_in
);

end structure;


  