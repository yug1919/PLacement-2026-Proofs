library ieee;
use IEEE.std_logic_1164.all;
library work;
use work.pkg.all;
use ieee.numeric_std.all;

entity cacheLM is
port( clk,reset: in std_logic;
		OPcode_from_EX_MEM_PR: in std_logic_vector(3 downto 0);
		D_MEM_MD_out: in M_data;
		RF_D3_M: out M_data
);
end entity;

architecture struct of cacheLM is
signal cache_mem: M_data := (others => (others => '0'));


begin
RF_D3_M <= cache_mem;

proc_basic: process(clk,reset)

begin
	if(reset ='1') then 
		cache_mem <= (others => (others => '0'));
	elsif(OPcode_from_EX_MEM_PR = "0110") then
		if(clk = '1' and clk'event) then
			cache_mem <= D_MEM_MD_out;
		end if;
	end if;
end process proc_basic;
end architecture;	
