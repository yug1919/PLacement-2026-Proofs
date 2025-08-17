library ieee;
use ieee.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity COMP is
    port(input_no : in  std_logic_vector(15 downto 0);
        output_no: out std_logic_vector(15 downto 0)
    );
end entity;

architecture struct of COMP is
begin
    output_no <= not input_no;
end architecture struct;
