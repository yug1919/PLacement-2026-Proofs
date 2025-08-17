library ieee;
use IEEE.std_logic_1164.all;
library work;
use work.pkg.all;
use ieee.numeric_std.all;

entity I_MEM is 
	port (clk, reset: in std_logic;
			PC: in std_logic_vector(15 downto 0);
			Instr_and_PC: out std_logic_vector(31 downto 0);
			Instr: out std_logic_vector(15 downto 0)
			);
end entity;

architecture struct of I_MEM is

signal In_and_PC: std_logic_vector(31 downto 0);
signal Instruction: std_logic_vector(15 downto 0);
signal I_memory: I_array := (others => "0010000000000011");

begin
process(clk)
begin
-- I_memory(0) <= ""; 
Instruction <= I_memory(to_integer(unsigned(PC)));
In_and_PC(31 downto 16) <= I_memory(to_integer(unsigned(PC)));
In_and_PC(15 downto 0) <= PC;

if(clk = '1' and clk'event) then
	Instr <= Instruction;
	Instr_and_PC <= In_and_PC;
end if;
end process;
end architecture;
