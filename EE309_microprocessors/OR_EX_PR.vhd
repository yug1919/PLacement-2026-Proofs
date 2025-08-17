library ieee;
use IEEE.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity OR_EX_PR is
port(clk, reset: in std_logic;
     PR_prev: in std_logic_vector(79 downto 0);
	  RF_D1,RF_D2: in std_logic_vector(15 downto 0);
	  PR_to_EX: out std_logic_vector(95 downto 0)
	  );
end entity;

architecture struct of OR_EX_PR is

signal PR_curr: std_logic_vector(95 downto 0);

begin 

process(clk,reset)
begin
	if(reset='1') then
		PR_curr <= (others => '0');
		else 
			PR_curr(95 downto 80) <= PR_prev(79 downto 64);
			PR_curr(79 downto 64) <= RF_D1;
			PR_curr(63 downto 48) <= RF_D2;
			PR_curr(47 downto 32) <= PR_prev(63 downto 48);
			PR_curr(31 downto 0) <= PR_prev(31 downto 0);
	end if;
	if(clk='1' and clk'event) then
		PR_to_EX <= PR_curr;
	end if;
end process;
end architecture;