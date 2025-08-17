library IEEE;
use IEEE.std_logic_1164.all;

package pkg is
  type M_data is array (7 downto 0) of std_logic_vector(15 downto 0);
  type I_array is array (15 downto 0) of std_logic_vector(15 downto 0);
  type D_array is array (31 downto 0) of std_logic_vector(15 downto 0);
end package;

package body pkg is
end package body;