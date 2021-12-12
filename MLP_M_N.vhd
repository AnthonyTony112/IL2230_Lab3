library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";
use work.all;
use ieee.fixed_pkg.all;
use work.CoeffPak.all;

entity datapath is
generic (
    M: integer := 3;
		N: integer := 3;
		int_bit: integer :=3;
		float_bit: integer :=5
	);
 port (CIN:     In DataArray; --input
      MLP_in:   In DataArray; --single_layer_out
      clk:      In std_logic;
      reset:    in std_logic;
      latency:  In integer;                             --layer_latency
      COUT:     Out DataArray;--out
      Mlp_out:  Out DataArray;--X
      addr:     Out std_logic_vector(7 downto 0);       --address
      lat_count:Out integer                             --latency_counter    
     
-- Reluout: Out sfixed (int_bit-1 downto -float_bit);
--		sigout: Out sfixed (int_bit-1 downto -float_bit)
      );
end datapath;

architecture structure of datapath is

signal lat, count_lat: integer:=0;
signal count_lay: integer:=0;
signal reg:  DataArray; 


begin


addr<=std_logic_vector(to_unsigned(count_lay,addr'length)); 
lat_count<=count_lat;  
  process(clk)
    begin
      if reset='1' then
        count_lay<=0;
        count_lat<=0;
        
      elsif(rising_edge(clk)) then
      lat<=latency; 
       
        if(count_lat>=lat-1) then
            if(count_lay>=M-1) then
                count_lay<=0;
                
                cout<=mlp_in;
                mlp_out<=cin; 
                
              else
               
                 mlp_out<=mlp_in;
                count_lay<=count_lay+1;
            
             end if;
            
            count_lat<=0;
        
--      elsif(count_lat=lat-1) then
--            
--            if(count_lay=M-1) then
--                cout<=mlp_in;
--              else
--                reg<=mlp_in;  
--             end if;
--            
--             count_lat<=count_lat+1;
--             
--            else count_lat<=count_lat+1;
          
          
     
        else count_lat<=count_lat+1;
       
        end if;
      
      end if;
      
    end process;
  
  
end structure;
