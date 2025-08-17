library ieee;
use ieee.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity SE10_1LS is
    port(
        input_no : in  std_logic_vector(5 downto 0);
        SE10_LS  : out std_logic_vector(15 downto 0)
    );
end entity;

architecture struct of SE10_1LS is
    signal temp: std_logic_vector(15 downto 0);  
begin
process(input_no)
variable i: integer;
    begin
        if (input_no(5) = '1') then
            for i in 6 to 15 loop
                temp(i) <= '1';
            end loop;
        else 
            for i in 6 to 15 loop
                temp(i) <= '0';
            end loop;
        end if;
        
        temp(5 downto 0) <= input_no;
        
        for i in 0 to 14 loop
            SE10_LS(i+1) <= temp(i);
        end loop;
        
        SE10_LS(0) <= '0';  
    end process;
end architecture;