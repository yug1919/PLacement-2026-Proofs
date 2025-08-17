library ieee;
use IEEE.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity EX_MEM_PR is
port(clk, reset: in std_logic;
     PR_prev: in std_logic_vector(95 downto 0);
	  Zprev,Cprev: in std_logic;
	  result_of_EX: in std_logic_vector(15 downto 0);
	  ALU1_C: in std_logic_vector(15 downto 0);
	  PR_to_MEM: out std_logic_vector(113 downto 0)
	  );
end entity;

architecture struct of EX_MEM_PR is

signal PR_curr: std_logic_vector(113 downto 0);

begin 

process(clk,reset)
begin
	if(reset='1') then
		PR_curr <= (others => '0');
		else 
			PR_curr(113) <= Zprev;
			PR_curr(112) <= Cprev;
			PR_curr(111 downto 96) <= PR_prev(95 downto 80);
			PR_curr(95 downto 80) <= result_of_EX;
			PR_curr(79 downto 64) <= ALU1_C;
			PR_curr(63 downto 48) <= PR_prev(79 downto 64);
			PR_curr(47 downto 0) <= PR_prev(47 downto 0);
	end if;
	if(clk='1' and clk'event) then
		PR_to_MEM <= PR_curr;
	end if;
end process;
end architecture;
