library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.numeric_std.all;
use ieee.fixed_pkg.all;
use work.all;


package CoeffPak is
	--generic (N: integer := 8; K: integer := 2; datawidth: integer := 8; decimal_width: integer := 4);
	
	--Local constants:(WARNING!!! THESE PARAMS MUST BE THE SAME TO THE PERIPHERALS)
	constant M: integer := 3;
	constant N: integer := 16;
	constant int_bit: integer := 3; 
	constant float_bit: integer := 5; 
	constant AddrWidth: integer := integer(ceil(log2(real(N))));
	
	--constant SignalLUTLength: integer := 64;
	--constant decimal_Shift_Coeff: integer := 2**decimal_width;
	
	--Type definition: 
	--subtype Data is std_logic_vector(float_bit+int_bit-1 downto 0);
	subtype Datafix is sfixed (int_bit-1 downto -float_bit);
	type DataArray is array(0 to N-1) of Datafix;
	type DataArray2D is array (0 to N-1) of DataArray;
	type DataArray3D is array (0 to M-1) of DataArray2D;
	--type DataBus is array(0 to 1) of Datafix;
	
	--Functions
	--function DataArray_to_DataBus(X: DataArray) return DataBus;	--Type casting
	
	--Datasheets
--constant W :DataArray := (
--		--(decimal_width => '1', others => '0'),	--1 in fixed-point style
--		--List your coeff here below::
--		
--		--
--		
--		--This is a demo for 3.5 8bit fixed-point filter.
--		--Lowpass for 4MHz @fs=25MHz.
--		x"fc",
--		x"06",
--		x"09",
--		x"0c",
--		x"0c",
--		x"09",
--		x"06",
--		x"fc"
--		----------------------------------------
--		--others => (others => '0')
--	);
	
--	constant Signal_LUT: SIG_LUT := (
--		--List your waveform table here:
--		1 => 0.5,
--		
--		----------------------------------------
--		others => 0.0
--	);
	
end package CoeffPak;

--package body CoeffPak is
	--function DataArray_to_DataBus(X: DataArray) return DataBus is
		--variable temp: DataBus;
--		constant k:integer:=2;
	--begin
--		if(K<=N) then
--			for i in 0 to K-1 loop
--				temp(i) := X(i);
--			end loop;
--		else
--			for i in 0 to N-1 loop
--				temp(i) := X(i);
--			end loop;
--		end if;
  --  temp:=(others=>(to_sfixed(0,int_bit,float_bit)));
		--return temp;
--	end function;
--end package body CoeffPak;