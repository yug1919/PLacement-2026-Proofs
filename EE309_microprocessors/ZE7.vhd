library ieee;
use ieee.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity ZE7 is
    port(input_no    : in  std_logic_vector(8 downto 0);
        zero_exed_7 : out std_logic_vector(15 downto 0)
    );
end entity;

architecture struct of ZE7 is
signal zero_exed_7_sig: std_logic_vector(15 downto 0);
begin
process(input_no)
variable i: integer;
begin
        for i in 9 to 15 loop
            zero_exed_7_sig(i) <= '0';
        end loop;
        zero_exed_7_sig(8 downto 0) <= input_no;
		  zero_exed_7 <= zero_exed_7_sig;
end process;
end architecture;
