LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE work.all  ; 
USE work.CoeffPak.all  ; 
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

ENTITY rom_tb  IS 
  GENERIC (
    float_bit  : INTEGER :=5;  
    int_bit  : INTEGER:=3;  
    N  : INTEGER :=3
    
    ); 
END ; 
 
ARCHITECTURE rom_tb_arch OF rom_tb IS
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL W   :  DataArray  ; 
  SIGNAL addr   :  std_logic_vector (AddrWidth-1 downto 0) ; 
  constant AddrWidth: integer:= integer(ceil(log2(real(N))));
  COMPONENT ROM  
    GENERIC ( 
      float_bit  : INTEGER ; 
      int_bit  : INTEGER ; 
      N  : INTEGER  );  
    PORT ( 
      clk  : in STD_LOGIC ; 
      W  : out DataArray ; 
      addr  : in std_logic_vector (AddrWidth-1 downto 0)); 
  END COMPONENT ; 
BEGIN
  DUT  : ROM  
    GENERIC MAP ( 
      float_bit  => float_bit  ,
      int_bit  => int_bit  ,
      N  => N   )
    PORT MAP ( 
      clk   => clk  ,
      W   => W  ,
      addr   => addr   ) ; 

process 
  begin
    clk<='1';
    wait for 1 ns;
    clk<='0';
    wait for 1 ns;
end process;


process 
  begin
addr<="01";
wait for 1000 ns;
end process;


END rom_tb_arch; 

