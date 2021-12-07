LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.MATH_REAL."CEIL"  ; 
USE ieee.MATH_REAL."LOG2"  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE work.all  ; 
use ieee.fixed_pkg.all;
--use std.env.stop;

ENTITY parallel_neuron_tb  IS 
  GENERIC (
    float_bit  : INTEGER   := 20 ;  
    int_bit  : INTEGER   := 12 ;  
    N  : INTEGER   := 64 ); 
END ; 
 
ARCHITECTURE parallel_neuron_tb_arch OF parallel_neuron_tb IS
  SIGNAL X   :  sfixed(int_bit-1 downto -float_bit); 
  SIGNAL W   :  sfixed(int_bit-1 downto -float_bit);
  signal Reluout: sfixed (int_bit-1 downto -float_bit);
	signal sigout: sfixed (int_bit-1 downto -float_bit);
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  
  type DataArray is array (0 to 63) of sfixed (int_bit-1 downto -float_bit);

  constant Xin: DataArray:=( "00000000000000000000000000000000",
"00000001000000010000000100000001",
"00000010000000100000001000000010",
"00000011001000110000001100100011",
"00000000000001000000000000000100",
"00000001000001010000000100000101",
"00000010001001100000001000100110",
"11111001001001111111100100100111",
"00000000000000000000000000000000",
"00000001000000010000000100000001",
"11100010000000101110001000000010",
"00000011001000110000001100100011",
"11111100000001001111110000000100",
"00000001000001010000000100000101",
"00000110001001100000011000100110",
"00000001001001110000000100100111",

"00000000000000000000000000000000",
"00000001000000010000000100000001",
"00000010000000100000001000000010",
"00000011001000110000001100100011",
"00000000000001000000000000000100",
"00000001000001010000000100000101",
"00000010001001100000001000100110",
"11111001001001111111100100100111",
"00000000000000000000000000000000",
"00000001000000010000000100000001",
"11100010000000101110001000000010",
"00000011001000110000001100100011",
"11111100000001001111110000000100",
"00000001000001010000000100000101",
"00000110001001100000011000100110",
"00000001001001110000000100100111",

"00000000000000000000000000000000",
"00000001000000010000000100000001",
"00000010000000100000001000000010",
"00000011001000110000001100100011",
"00000000000001000000000000000100",
"00000001000001010000000100000101",
"00000010001001100000001000100110",
"11111001001001111111100100100111",
"00000000000000000000000000000000",
"00000001000000010000000100000001",
"11100010000000101110001000000010",
"00000011001000110000001100100011",
"11111100000001001111110000000100",
"00000001000001010000000100000101",
"00000110001001100000011000100110",
"00000001001001110000000100100111",

"00000000000000000000000000000000",
"00000001000000010000000100000001",
"00000010000000100000001000000010",
"00000011001000110000001100100011",
"00000000000001000000000000000100",
"00000001000001010000000100000101",
"00000010001001100000001000100110",
"11111001001001111111100100100111",
"00000000000000000000000000000000",
"00000001000000010000000100000001",
"11100010000000101110001000000010",
"00000011001000110000001100100011",
"11111100000001001111110000000100",
"00000001000001010000000100000101",
"00000110001001100000011000100110",
"00000001001001110000000100100111"
    );

    
constant Weight :DataArray := (
"00000000000100000001111111111100",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000011110000000000001111",
"00000000000100000000001110010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000011111010000",
"00000000000100000000000000010000",
"00000001000111110000101100011111",
"00000000000100000000000000010000",
"00000000000100000000000111111110",

"00000000000100000001111111111100",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000011110000000000001111",
"00000000000100000000001110010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000011111010000",
"00000000000100000000000000010000",
"00000001000111110000101100011111",
"00000000000100000000000000010000",
"00000000000100000000000111111110",


"00000000000100000001111111111100",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000011110000000000001111",
"00000000000100000000001110010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000011111010000",
"00000000000100000000000000010000",
"00000001000111110000101100011111",
"00000000000100000000000000010000",
"00000000000100000000000111111110",


"00000000000100000001111111111100",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000011110000000000001111",
"00000000000100000000001110010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000000000010000",
"00000000000100000000011111010000",
"00000000000100000000000000010000",
"00000001000111110000101100011111",
"00000000000100000000000000010000",
"00000000000100000000000111111110"
);

   
      
  COMPONENT parallel_neuron  
    GENERIC ( 
      float_bit  : INTEGER ; 
      int_bit  : INTEGER ; 
      N  : INTEGER  );  
    PORT ( 
      X  : in sfixed(int_bit-1 downto -float_bit) ; 
      W : in sfixed(int_bit-1 downto -float_bit) ; 
     Reluout: out sfixed (int_bit-1 downto -float_bit);
	 sigout: out sfixed (int_bit-1 downto -float_bit);
      clk  : in STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : parallel_neuron  
    GENERIC MAP ( 
      float_bit  => float_bit  ,
      int_bit  => int_bit  ,
      N  => N   )
    PORT MAP ( 
      X   => X  ,
      W   => W,
      Reluout=>Reluout ,
      sigout =>sigout,
      clk   => clk  ,
      reset   => reset   ) ; 
      
process
  begin
    clk<='1';
    wait for 1 ns;
    clk<='0';
    wait for 1 ns;
end process;
      
 TEST: process
        begin
            reset<='1';
            wait for 2 ns;
            reset<='0';
            
            
            for i in 1 to N-1 loop
             
              X<=Xin(i);
              W<=Weight(i);
            wait until rising_edge(clk);
           end loop;
             wait for 2000 ns;
end process;
END ; 

