library ieee;
use IEEE.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity RF_W_writer is 
port(clk,reset: in std_logic;
	  RF_W_inp: in std_logic;
	  Cprev: in std_logic;
	  Zprev: in std_logic;
	  Opcode: in std_logic_vector(3 downto 0);
	  lsb_3: in std_logic_vector(2 downto 0);
	  RF_W: out std_logic);
end entity;

architecture struct of RF_W_writer is 

signal RF_W_sig: std_logic;

begin 

process (RF_W_inp, Cprev, Zprev, Opcode, lsb_3, reset)
begin
	if(reset = '1') then 
		RF_W_sig <= '0';
	elsif (Opcode = "0001" or Opcode = "0010") then
		if(lsb_3 = "010" or lsb_3 = "110") then
			RF_W_sig <= Cprev;
		elsif(lsb_3 = "001" or lsb_3 = "101") then
			RF_W_sig <= Zprev;
		else RF_W_sig <= RF_W_inp;
		end if;
	else RF_W_sig <= RF_W_inp;
	end if;
	
if (clk ='1' and clk'event) then
	RF_W <= RF_W_sig;
end if;

end process;
end architecture;

