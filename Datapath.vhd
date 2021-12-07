library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;
use work.all;
use work.CoeffPak.all;
use ieee.fixed_pkg.all;

entity DataPath is
	generic (
		N: integer := 4;
		int_bit: integer :=3;
		float_bit: integer :=5
	);
	port (
		X: In DataArray:=(others=>(others=>'0'));
		Output: Out sfixed(int_bit-1 downto -float_bit);
		new_result: Out std_logic;
		n_ready: In std_logic;
		--counter: in std_logic;
		read_count: in std_logic_vector;
		clk, reset: In std_logic
	);
end DataPath;

architecture behave of Datapath is
signal X_in, W_in, C_reg, AdderResult: sfixed(int_bit-1 downto -float_bit);

constant b: sfixed(int_bit-1 downto -float_bit):=(others=>'0');
type DataArray is array(0 to 63) of Datafix;


constant Weight :DataArray := (
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000000000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000111100001111",
"0000010000000000",
"0000010000100000",

"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000000000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000111100001111",
"0000010000000000",
"0000010000100000",


"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000000000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000111100001111",
"0000010000000000",
"0000010000100000",


"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000000000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000010000100000",
"0000111100001111",
"0000010000000000",
"0000010000100000");

begin
 
U0_MAU: entity work.MAU(behave)
			   generic map(int_bit, float_bit)
				port map (
				A => W_in,
				B => X_in,
				C => C_reg,
				Output => AdderResult);
			
process (clk,reset) is
begin
  if reset='1' then
	C_reg <=(OTHERS => '0');
	new_result <= '0';
  elsif rising_edge(clk) then
    if n_ready='1' then 
	    if unsigned(read_count)=0 then
	     --if unsigned(write_count)<N-1 then
	      --DataReg(to_integer(unsigned(write_count)))<=X;
	      X_in<=b;
		    W_in<=Weight(0);
		    C_reg<=(OTHERS => '0');  
			elsif unsigned(read_count)<=N-1 then
			  
	      X_in<=X(to_integer(unsigned(read_count)));
		    W_in<=Weight(to_integer(unsigned(read_count)));
		    C_reg<=AdderResult;
	    end if; 
	  elsif n_ready='0' then
		    Output<=AdderResult;
		    new_result<='1'; 
		end if;   
	end if;

end process;	
end behave;