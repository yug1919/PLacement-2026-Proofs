library ieee;
use IEEE.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity ID_OR_PR is
port(clk, reset: in std_logic;
     PR_prev: in std_logic_vector(47 downto 0);
	  CNTRL_SIGNS: in std_logic_vector(31 downto 0);
	  PR_to_OR: out std_logic_vector(79 downto 0)
	  );
end entity;

architecture struct of ID_OR_PR is

signal PR_curr: std_logic_vector(79 downto 0);

begin 

process(clk,reset)
begin
	if(reset='1') then
		PR_curr <= (others => '0');
		else 
			PR_curr(79 downto 64) <= PR_prev(47 downto 32);
			PR_curr(31 downto 0) <= CNTRL_SIGNS;
			PR_curr(63 downto 48) <= PR_prev(31 downto 16);
			PR_curr(47 downto 32) <= PR_prev(15 downto 0);
	end if;
	if(clk='1' and clk'event) then
		PR_to_OR <= PR_curr;
	end if;
end process;
end architecture;