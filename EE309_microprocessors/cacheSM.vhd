library ieee;
use IEEE.std_logic_1164.all;
library work;
use work.pkg.all;
use work.MUX.all;
use ieee.numeric_std.all;

entity cacheSM is 
	port(clk, reset: in std_logic;
		  OPcode_from_ID_OR: in std_logic_vector(3 downto 0);
		  RF_DM: in M_data;
		  D_MEM_MD_in: out M_data
	);
end entity;

architecture struct of cacheSM is
signal cache_mem: M_data := (others => (others => '0'));


begin
D_MEM_MD_in <= cache_mem;

proc_basic: process(clk,reset)
begin
	if(reset ='1') then 
		cache_mem <= (others => (others => '0'));
	elsif(OPcode_from_ID_OR = "0111") then
		if(clk = '1' and clk'event) then
			cache_mem <= RF_DM;
		end if;
	end if;
end process proc_basic;
end architecture;	