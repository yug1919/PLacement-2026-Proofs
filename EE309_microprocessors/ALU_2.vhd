library ieee;
use ieee.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity ALU_2 is
    port(
        clk,reset: in  std_logic;
        A_in     : in  std_logic_vector(15 downto 0);
        result   : out std_logic_vector(15 downto 0)
    );
end entity;

architecture struct of ALU_2 is
	 signal result_sig: std_logic_vector(15 downto 0);

begin
    
process(reset)
variable temp: integer;
    begin
        if(reset = '1') then
				result_sig <= (others => '0');
        else
				temp := to_integer(unsigned(A_in)) + 2;
				result_sig <= std_logic_vector(to_unsigned(temp, 16));
				if(clk ='1' and clk'event) then
					result <= result_sig;
				end if;
        end if;
end process;
end architecture;