library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";
use work.all;
use ieee.fixed_pkg.all;
use work.CoeffPak.all;

entity parallel_neuron is
generic (
		N: integer := 3;
		int_bit: integer :=3;
		float_bit: integer :=5
	);
 port (X,W: In DataArray:=(others=>(others=>'0'));
       b: In sfixed(int_bit-1 downto -float_bit);
       LCounter: in integer;
       reset,clk: in std_logic;
		   output : out sfixed(int_bit-1 downto -float_bit)
		   );
end parallel_neuron;

architecture structure of parallel_neuron is


signal output_reg : DataArray;
signal output_linear : Datafix;
signal output_reg_temp : DataArray;
signal output_bias : Datafix;

signal C0: sfixed(int_bit-1 downto -float_bit):=(others=>'0');
		
begin 

--MAU_0: entity work.MAU(behave)
--			 generic map(int_bit, float_bit)
--				port map (
--				A => W(0),
--				B => b,
--				C => C0,
--				Output => output_reg(0));
--				
--output_reg(0) <= (others=>'0');
--g1: for j in 1 to N generate
--  begin
--  MAU_1 : entity work.MAU(behave)
--  generic map(int_bit, float_bit)
--  port map (
--        A => W(j-1),
--				B => X(j-1),
--				C => output_reg(j-1), 
--				Output => output_reg(j));
--end generate;
--
--output_bias<=output_reg(N)+b;


MAU_0: entity work.MAU(behave)
			 generic map(int_bit, float_bit)
				port map (
				A => W(0),
				B => b,
				C => C0,
				Output => output_reg(0));
				
g1: for i in 1 to N-1 generate
  begin
  MAU_1 : entity work.MAU(behave)
  generic map(int_bit, float_bit)
  port map (
        A => W(i),
				B => X(i),
				C => output_reg(i-1), 
				Output => output_reg(i));
end generate;
output_bias<=output_reg(N-1);



RELu: entity work.nonlinear(behave)
generic map(int_bit, float_bit)
port map(
output=>output_bias,
reluout=>output_linear );

output<= output_linear;



end structure;