LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.MATH_REAL."CEIL"  ; 
USE ieee.MATH_REAL."LOG2"  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE work.all  ; 
use ieee.fixed_pkg.all;
use std.env.stop;
use work.CoeffPak.all;

ENTITY test_serial_neuron  IS 
  GENERIC (
    float_bit  : INTEGER   := 10 ;  
    int_bit  : INTEGER   := 6 ;  
    N  : INTEGER   := 2); 
END ; 
 
ARCHITECTURE test_serial_neuron_arch OF test_serial_neuron IS
  SIGNAL new_result   :  STD_LOGIC  ; 
  
  signal X: DataArray:=(others=>(others=>'0')); 
  signal Reluout: sfixed(int_bit-1 downto -float_bit);
	signal sigout: sfixed (int_bit-1 downto -float_bit);
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  type XinArray is array (0 to 63) of Datafix;
  constant Xin: XinArray:=( "0000000000000000",
"0000000100000001",
"0000001000000010",
"0010001100100011",
"0000010000000100",
"0000010100000101",
"0010011000100110",
"0010011100100111",
"0000000000000000",
"0000000100000001",
"0000001000000010",
"0010001100100011",
"0000010000000100",
"0000010100000101",
"0010011000100110",
"0010011100100111",

"0000000000000000",
"0000000100000001",
"0000001000000010",
"0010001100100011",
"0000010000000100",
"0000010100000101",
"0010011000100110",
"0010011100100111",
"0000000000000000",
"0000000100000001",
"0000001000000010",
"0010001100100011",
"0000010000000100",
"0000010100000101",
"0010011000100110",
"0010011100100111",

"0000000000000000",
"0000000100000001",
"0000001000000010",
"0010001100100011",
"0000010000000100",
"0000010100000101",
"0010011000100110",
"0010011100100111",
"0000000000000000",
"0000000100000001",
"0000001000000010",
"0010001100100011",
"0000010000000100",
"0000010100000101",
"0010011000100110",
"0010011100100111",

"0000000000000000",
"0000000100000001",
"0000001000000010",
"0010001100100011",
"0000010000000100",
"0000010100000101",
"0010011000100110",
"0010011100100111",
"0000000000000000",
"0000000100000001",
"0000001000000010",
"0010001100100011",
"0000010000000100",
"0000010100000101",
"0010011000100110",
"0010011100100111");
  
  COMPONENT serial_neuron  
    GENERIC ( 
      float_bit  : INTEGER ; 
      int_bit  : INTEGER ; 
      N  : INTEGER  );  
    PORT ( 
      new_result  : out STD_LOGIC ; 
      X  : in DataArray:=(others=>(others=>'0')); 
      Reluout: Out sfixed(int_bit-1 downto -float_bit);
		 sigout: Out sfixed (int_bit-1 downto -float_bit);
      clk  : in STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : serial_neuron  
    GENERIC MAP ( 
      float_bit  => float_bit  ,
      int_bit  => int_bit  ,
      N  => N   )
    PORT MAP ( 
      new_result   => new_result  ,
      X   => X  ,
      Reluout =>Reluout,
		sigout =>sigout  ,
      clk   => clk  ,
      reset   => reset  
   ) ; 
      
process 
  begin
    clk<='1';
    wait for 1 ns;
    clk<='0';
    wait for 1 ns;
end process;


process
        begin
            reset<='1';
            wait for 2 ns;
           reset<='0';
        
          for i in 1 to N-1 loop
          
          X(i)<=Xin(i);
          wait until rising_edge(clk);
          end loop;
          wait for 2000 ns;
end process;

end test_serial_neuron_arch; 
