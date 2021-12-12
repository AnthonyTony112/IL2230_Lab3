library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";
use work.all;
use ieee.fixed_pkg.all;
use work.CoeffPak.all;

entity parallel_layer is 
	generic (
		N: integer := 3;
		int_bit: integer :=3;
		float_bit: integer :=5
	);
port(
X: In DataArray:=(others=>(others=>'0'));
W: In DataArray2D:=(others=>(others=>(others=>'0')));
b: In sfixed(int_bit-1 downto -float_bit);
LCounter: in integer;
reset,clk: in std_logic;
Result: out DataArray;
new_result: Out std_logic);
end parallel_layer;

architecture structure of parallel_layer is

signal X_in: DataArray;
signal W_in: DataArray2D;
  
begin
process(clk, reset) begin
  if reset='1' then
   X_in<=(others=>(others=>'0')); 
   W_in<=(others=>(others=>(others=>'0'))); 
   new_result <= '0';
  elsif (LCounter=0) then
    
      X_in<=X;
  
      W_in<=W; 
      
      new_result <= '1';
      Result(0) <= b;
  end if;
end process; 

layer_g1: for i in 1 to N-1 generate
  begin
  parallel_neuron_1 : entity work.parallel_neuron(structure)
  generic map(N, int_bit, float_bit)
  port map (
           X => X_in, 
           W => W_in(i), 
           b => b,
           LCounter => LCounter,
           reset => reset,
           clk => clk,
           output => Result(i)
           );
end generate;

  

end structure;