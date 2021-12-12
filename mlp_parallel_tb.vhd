LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.MATH_REAL."CEIL"  ; 
USE ieee.MATH_REAL."LOG2"  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE work.all  ; 
USE work.CoeffPak.all  ; 
use ieee.fixed_pkg.all;

ENTITY mlp_parallel_tb  IS 
  GENERIC (
    float_bit  : INTEGER   := 5 ;  
    int_bit  : INTEGER   := 3 ;  
    N  : INTEGER   := 3 ); 
END ; 
 
ARCHITECTURE mlp_parallel_tb_arch OF mlp_parallel_tb IS
  SIGNAL X   :  DataArray:=(others=>(others=>'0')); 
  SIGNAL Output   :  DataArray  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL b   :  sfixed(int_bit-1 downto -float_bit)  ; 
  SIGNAL L_Latency   :  INTEGER  ; 
  SIGNAL reset   :  STD_LOGIC  ;
  constant X_in: DataArray:=( 
  "00100000",
  "00100000",
  "00100000"
  ); 
  COMPONENT MLP_parallel  
    GENERIC ( 
      float_bit  : INTEGER ; 
      int_bit  : INTEGER ; 
      N  : INTEGER  );  
    PORT ( 
      X  : in DataArray:=(others=>(others=>'0')) ; 
      Output  : out DataArray  ; 
      clk  : in STD_LOGIC ; 
      b  : in sfixed(int_bit-1 downto -float_bit) ; 
      L_Latency  : in INTEGER ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : MLP_parallel  
    GENERIC MAP ( 
      float_bit  => float_bit  ,
      int_bit  => int_bit  ,
      N  => N   )
    PORT MAP ( 
      X   => X  ,
      Output   => Output  ,
      clk   => clk  ,
      b   => b  ,
      L_Latency   => L_Latency  ,
      reset   => reset   ) ; 
      
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
  wait for 1 ns;
  reset<='0';                
    b<="00100000";
    L_Latency<=1;
            
    X<=X_in;
    
   wait for 2000 ns;
       
end process;
      

END mlp_parallel_tb_arch; 

