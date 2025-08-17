library ieee;
use IEEE.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity IF_ID_PR is
port(clk, reset: in std_logic;
	  INSTR_and_PC: in std_logic_vector(47 downto 0);
	  PC_plus_2: in std_logic_vector(15 downto 0);
	  PR_to_ID: out std_logic_vector(47 downto 0)
	  );
end entity;

architecture struct of IF_ID_PR is

signal PR_curr: std_logic_vector(47 downto 0);

begin 

process(clk,reset)
begin
	if(reset='1') then
		PR_curr <= (others => '0');
		else 
			PR_curr(47 downto 16) <= INSTR_and_PC(47 downto 16);
			PR_curr(15 downto 0) <= PC_plus_2;
	end if;
	if(clk='1' and clk'event) then
		PR_to_ID <= PR_curr;
	end if;
end process;
end architecture;