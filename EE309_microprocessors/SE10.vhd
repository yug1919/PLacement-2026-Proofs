library ieee;
use ieee.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity SE10 is
    port(
        input_no    : in  std_logic_vector(5 downto 0);
        sign_exed_10: out std_logic_vector(15 downto 0)
    );
end entity;

architecture struct of SE10 is
begin
process(input_no)
variable i: integer;
    begin
        if (input_no(5) = '1') then
            for i in 6 to 15 loop
                sign_exed_10(i) <= '1';
            end loop;
        else 
            for i in 6 to 15 loop
                sign_exed_10(i) <= '0';
            end loop;
        end if;
        sign_exed_10(5 downto 0) <= input_no;
    end process;
end architecture;
