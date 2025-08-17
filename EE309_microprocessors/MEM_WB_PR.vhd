library ieee;
use IEEE.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity MEM_WB_PR is
	port(clk, reset: in std_logic;
	PR_prev: in std_logic_vector(113 downto 0);
	D_MEM_D_out: in std_logic_vector(15 downto 0);
	PR_to_WB: out std_logic_vector(111 downto 0)
	);
end entity;

architecture struct of MEM_WB_PR is
signal PR_curr: std_logic_vector(111 downto 0);

begin

process(clk,reset, PR_prev, D_MEM_D_OUT)
begin
	if(reset='1') then
		PR_curr <= (others => '0');
		else 
			PR_curr(111 downto 64) <= PR_prev(111 downto 64);
			PR_curr(63 downto 48) <= D_MEM_D_out;
			PR_curr(47 downto 0) <= PR_prev(47 downto 0);
	end if;
	if(clk='1' and clk'event) then
		PR_to_WB <= PR_curr;
	end if;
end process;
end architecture;