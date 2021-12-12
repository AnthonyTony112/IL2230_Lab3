LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.MATH_REAL."CEIL"  ; 
USE ieee.MATH_REAL."LOG2"  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE work.all  ; 
USE work.CoeffPak.all  ; 
use ieee.fixed_pkg.all;

ENTITY parallel_layer_tb  IS 
  GENERIC (
    float_bit  : INTEGER   := 5 ;  
    int_bit  : INTEGER   := 3 ;  
    N  : INTEGER   := 3 ); 
END ; 
 
ARCHITECTURE parallel_layer_tb_arch OF parallel_layer_tb IS
  SIGNAL new_result   :  STD_LOGIC  ; 
  SIGNAL LCounter   :  INTEGER  ; 
  SIGNAL X   : DataArray:=(others=>(others=>'0')); 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL b   :  sfixed(int_bit-1 downto -float_bit); 
  SIGNAL Result   :  DataArray  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  SIGNAL W   :  DataArray:=(others=>(others=>'0'));
   constant X_in: DataArray:=( 
  "00100000",
  "00100000",
  "00100000"
  );
  
  constant Weight: DataArray:=( 
  "00100000",
  "00010000",
  "00011000"
  );
  COMPONENT parallel_layer  
    GENERIC ( 
      float_bit  : INTEGER ; 
      int_bit  : INTEGER ; 
      N  : INTEGER  );  
    PORT ( 
      new_result  : out STD_LOGIC ; 
      LCounter  : in INTEGER ; 
      X  : in DataArray:=(others=>(others=>'0'));  
      clk  : in STD_LOGIC ; 
      b  : in sfixed(int_bit-1 downto -float_bit);
      Result  : out DataArray ; 
      reset  : in STD_LOGIC ; 
      W  : in DataArray:=(others=>(others=>'0')) ); 
  END COMPONENT ; 
BEGIN
  DUT  : parallel_layer  
    GENERIC MAP ( 
      float_bit  => float_bit  ,
      int_bit  => int_bit  ,
      N  => N   )
    PORT MAP ( 
      new_result   => new_result  ,
      LCounter   => LCounter  ,
      X   => X  ,
      clk   => clk  ,
      b   => b  ,
      Result   => Result  ,
      reset   => reset  ,
      W   => W   ) ; 

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
    b<="00100000";
    LCounter<=1;
    for i in 0 to N-1 loop           
    X(i)<=X_in(i);
    W(i)<=Weight(i);
    end loop;
   wait for 2000 ns;
       
end process;      
      

END parallel_layer_tb_arch; 

