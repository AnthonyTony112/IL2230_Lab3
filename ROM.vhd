library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
USE work.all  ; 
USE work.CoeffPak.all  ; 
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

entity ROM is
generic (
		N: integer:=3;
		M: integer:=3;
		int_bit: integer:=3;
		float_bit: integer:=5	
	);

port(addr: in std_logic_vector (7 downto 0);
     clk: in std_logic; 
     W: out DataArray2D);
end ROM;

architecture behave of ROM is
--type LayerArray is array (0 to N) of DataArray ;
--type WeightArray is array (0 to M) of LayerArray ;
Constant Weight: DataArray3D:=

(

( 
  ("00100000",
  "00010000",
  "00011000"),
  
   ("00100000",
  "00010000",
  "00011000"),

   ("00100000",
    "00010000",
    "00011000")
) , --layer0

(
  ("00100000",
   "00010000",
   "00011000"),
   
   ("00100000",
   "00010000",
   "00011000"),

   ("00100000",
    "00010000",
    "00011000")
),  --layer1

(
  ("00100000",
   "00010000",
   "00011000"),
   
   ("00100000",
   "00010000",
   "00011000"),

   ("00100000",
    "00010000",
    "00011000")
), --layer2

others=>(others=>(others=>(others=>'0')))
);
     
begin
  W<=Weight(to_integer(unsigned(addr)));

end behave;