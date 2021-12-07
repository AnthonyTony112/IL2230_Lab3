library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";
use work.all;
use ieee.fixed_pkg.all;

entity parallel_neuron is
generic (
		N: integer := 64;
		int_bit: integer :=20;
		float_bit: integer :=12
	);
 port (X,W: In sfixed(int_bit-1 downto -float_bit);
       reset,clk: in std_logic;
		 Reluout: Out sfixed (int_bit-1 downto -float_bit);
		sigout: Out sfixed (int_bit-1 downto -float_bit));
end parallel_neuron;

architecture structure of parallel_neuron is

constant b: sfixed(int_bit-1 downto -float_bit):=(others=>'0');
SIGNAL output : sfixed(int_bit-1 downto -float_bit);


--register of X
type reg_type is array (N-1 downto 0) of sfixed(int_bit-1 downto -float_bit);
signal X_in: reg_type;
signal W_in: reg_type;

--output of every units
type output_type is array (N downto 0) of sfixed(int_bit-1 downto -float_bit);
signal output_reg : output_type;


constant CounterWidth: integer := integer(ceil(log2(real(N))));

signal Counter: std_logic_vector (CounterWidth-1 downto 0);

signal n_ready: std_logic;

begin

process(clk, reset) begin
			case reset is
				when '1' =>
					Counter <= (others => '0');
					X_in <= (others => (others => '0'));
					n_ready <= '1' ;	
				when others =>
					if(rising_edge(clk)) then
						for i in N-1 downto 2 loop
							X_in(i) <= X_in(i-1);
							W_in(i) <=W_in(i-1);
						end loop;
						 X_in(1) <= X;
						 X_in(0) <= b;
						 W_in(1) <=W;
						 W_in(0) <= (0=>'1',others=>'0');
						if(unsigned(Counter)=N) then
							n_ready <= '0';
						else
							Counter <= std_logic_vector(unsigned(Counter) + 1);
						end if;
					end if;
			end case;
		end process;

output_reg(0) <= (others=>'0');
g1: for j in 1 to N generate
  begin
  MAU_1 : entity work.MAU(behave)
  generic map(int_bit, float_bit)
  port map (
        A => W_in(j-1),
				B => X_in(j-1),
				C => output_reg(j-1), 
				Output => output_reg(j));
end generate;
output<= output_reg(N);

nonlinear_1: entity work.nonlinear(behave)
generic map (int_bit, float_bit)
port map (output => output,
          Reluout => Reluout,
		      sigout => sigout);

end structure;


  
  
		
