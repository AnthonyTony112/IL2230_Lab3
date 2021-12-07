library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

entity FSM is
generic (
		N: integer := 4;
		int_bit: integer :=3;
		float_bit: integer :=5
	);
port (clk,reset: in std_logic;
     n_ready: out std_logic;
      --counter: Out std_logic;
      read_count: Out std_logic_vector
     );
		
end FSM;

architecture behave of FSM is
type state_type is (initialize,counting,result);
signal pres_state, next_state: state_type;
constant CounterWidth: integer := integer(ceil(log2(real(N))));

signal read_Counter: std_logic_vector (CounterWidth-1 downto 0);

begin
process(reset,clk)
begin
 if reset='1' then
    read_Counter<= (others=>'0');
    pres_state<=initialize;
  elsif rising_edge(clk) then
    pres_state<=next_state;
    
     case pres_state is
					when initialize|counting  =>
						read_Counter<=std_logic_vector(unsigned(read_Counter) + 1);
					when result=> 
						read_Counter<=(others=>'0');
					when others=> null;
				end case;
  end if;
end process;
      
process (pres_state,read_Counter)
begin 
case pres_state is 
	when initialize =>
	  n_ready<='1';
	   --counter<='0';
	   next_state<=counting;
	   --else
	   --n_ready<='1';
	   --next_state<=initialize;
	  --end if;
	when counting =>
	  if (unsigned(read_Counter)>=N-1) then
	  --counter<='0';
	  n_ready<='1';
	  next_state<=result;
	  --else 
	  --counter<='1';
	  --n_ready<='1';
	  --next_state<=counting;
	  end if;
	when result =>
	  n_ready<='0';
	  --counter<='0';
	  next_state<=initialize;
	end case;
end process;	
read_count<=read_Counter;  
--write_count<=write_Counter;
end behave;