library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

entity C_Z_writer is 
	port(clk,reset,C,Z: in std_logic;
		  Zprev,Cprev: out std_logic
		  );
end entity;

architecture struct of C_Z_Writer is

signal Cprev_sig, Zprev_sig: std_logic;

begin

process(clk,reset,C,Z)
begin
	if (reset ='1') then
		Cprev_sig <= '0';
		Zprev_sig <= '0';
	else
		Cprev_sig <= C;
		Zprev_sig <= Z;
	end if;
	if (clk ='1' and clk'event) then
		Cprev <= Cprev_sig;
		Zprev <= Zprev_sig;
	end if;
end process;
end architecture;