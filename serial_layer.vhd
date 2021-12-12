library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";
use work.all;
use ieee.fixed_pkg.all;
use work.CoeffPak.all;

entity serial_layer is 
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
end serial_layer;

architecture structure of serial_layer is

signal X_in,W_in: DataArray;
signal Result_temp: Datafix;
signal counter_reg: integer;

begin
  
neuron_1: entity work.parallel_neuron(structure)
generic map(N, int_bit, float_bit)
port map(     X => X_in, 
           W => W_in, 
           b => b,
           LCounter => LCounter,
           reset => reset,
           clk => clk,
           output => Result_temp
           );  
           
process(clk, reset, Lcounter) begin
  
  if reset='1' then
   X_in<=(others=>(others=>'0')); 
   W_in<=(others=>(others=>'0')); 
   new_result <= '0';
  elsif LCounter'event then--(LCounter /= counter_reg) then
    
        X_in<=X;
        W_in<=W(Lcounter); 
        --if rising_edge(clk) then
        result(LCounter) <= Result_temp ;
        counter_reg<= LCounter;
      --end if;
      
  end if;
        --Result(0) <= b ;
end process; 

end structure;