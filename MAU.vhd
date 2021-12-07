library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity MAU is
	generic (int_bit: integer := 12; float_bit: integer := 20);
	port (
		A, B, C: In sfixed (int_bit-1 downto -float_bit);
		Output: Out sfixed (int_bit-1 downto -float_bit)
	);
end MAU;

architecture behave of MAU is
	--signal MULT:sfixed (N-1 downto -(float_bit-1)):=(others=>'0');
	begin
		--Output <= resize(arg=>A*B+C,size_res=>C,round_style=>fixed_truncate,overflow_style=>fixed_wrap);
		Output <= resize(arg=>A*B+C,size_res=>C);
end behave;


