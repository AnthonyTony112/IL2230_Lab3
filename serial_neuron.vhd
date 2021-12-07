library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;
use work.all;
use ieee.fixed_pkg.all;
use work.CoeffPak.all;

entity serial_neuron is
generic (
		N: integer := 2;
		int_bit: integer :=6;
		float_bit: integer :=10
	);
port (X: In DataArray:=(others=>(others=>'0'));
		
		new_result: Out std_logic;
		Reluout: Out sfixed (int_bit-1 downto -float_bit);
		sigout: Out sfixed (int_bit-1 downto -float_bit);
		clk, reset: In std_logic
	);
end serial_neuron;

architecture structure of serial_neuron is
signal n_ready: std_logic;
--signal Counter: std_logic;
constant CounterWidth: integer := integer(ceil(log2(real(N))));
signal read_count: std_logic_vector(CounterWidth-1 downto 0);
signal Output: sfixed(int_bit-1 downto -float_bit);
begin
	FSM_U: entity work.FSM(behave)
	generic map (N, int_bit, float_bit)
	port map (clk=>clk,
	          reset=>reset,
				 n_ready=>n_ready,
				 --counter=>Counter,
				 read_count=>read_count);
				 
	Datapath_U: entity work.Datapath(behave)
	generic map (N, int_bit, float_bit)
	port map (clk=>clk,
	          reset=>reset,
				   X=>X,
				   read_count=>read_count,
				   
				   n_ready=>n_ready,
				   --counter=>Counter,
				   Output=>Output,
				   new_result=>new_result);
				   
	nonlinear_U: entity work.nonlinear(behave)
	generic map (int_bit,float_bit)
	port map (output => Output,
	          Reluout=>Reluout,
		       sigout=>sigout);
				 
end structure;
	
	