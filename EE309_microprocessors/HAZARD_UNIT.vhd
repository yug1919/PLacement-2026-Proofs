library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HAZARD is
port(Instruct : in std_logic_vector(15 downto 0);
	  clk : in std_logic;
	  control1 : out std_logic;
	  control2 : out std_logic;
	  control3 : out std_logic);
end entity HAZARD;

architecture Behav of HAZARD is
-- input generation
	 type VectorArray is array (0 to 3) of std_logic_vector(15 downto 0);
    signal vector : VectorArray;
	 signal temp_cont1,temp_cont2,temp_cont3 : std_logic := '0'; 
	 begin
	 vector <= (others => "0000000000000000");
    process(clk)
    begin
        if rising_edge(clk) then
            for i in 0 to 3 loop
                vector(3-i) <= Instruct;
            end loop;
        end if;
   end process;

P1 : process(vector)
begin
if vector /= (others => "0000000000000000") then
for j in 3 downto 1 loop
if ((vector(j)(15 downto 12) = "0001") and (vector(j-1)(15 downto 12) = "0001")) or 
((vector(j)(15 downto 12) = "0010") and (vector(j-1)(15 downto 12) = "0010")) then
	if (vector(j)(5 downto 3) = vector(j-1)(8 downto 6)) or 
		(vector(j)(5 downto 3) = vector(j-1)(11 downto 9)) then
		temp_cont3 <= '1';
	else 
		null;
	end if;
else
null;
end if;
end loop;

for j in 3 downto 2 loop
if ((vector(j)(15 downto 12) = "0001") and (vector(j-2)(15 downto 12) = "0001")) or
((vector(j)(15 downto 12) = "0010") and (vector(j-2)(15 downto 12) = "0010")) then
	if (vector(j)(5 downto 3) = vector(j-2)(8 downto 6)) or 
		(vector(j)(5 downto 3) = vector(j-2)(11 downto 9)) then
		temp_cont2 <= '1';
	else 
		null;
   end if;
else
null;
end if;
end loop;

for j in 3 downto 3 loop
if ((vector(j)(15 downto 12) = "0001") and (vector(j-3)(15 downto 12) = "0001")) or
((vector(j)(15 downto 12) = "0010") and (vector(j-3)(15 downto 12) = "0010")) then
	if (vector(j)(5 downto 3) = vector(j-3)(8 downto 6)) or 
		(vector(j)(5 downto 3) = vector(j-3)(11 downto 9)) then
		temp_cont1 <= '1';
	else 
		null;
   end if;
else
null;
end if;
end loop;
	
end if;

end process;

P2 : process(vector)
begin
if vector /= (others => "0000000000000000") then
for j in 3 downto 1 loop
if ((vector(j)(15 downto 12) = "0000") and (vector(j-1)(15 downto 12) = "0010")) 
or ((vector(j)(15 downto 12) = "0000") and (vector(j-1)(15 downto 12) = "0001")) then
   
	if (vector(j)(8 downto 6) = vector(j-1)(8 downto 6)) or 
		(vector(j)(8 downto 6) = vector(j-1)(11 downto 9)) then
		temp_cont3 <= '1';
	else 
		null;
	end if;
else
null;
end if;
end loop;
for j in 3 downto 2 loop
if ((vector(j)(15 downto 12) = "0000") and (vector(j-2)(15 downto 12) = "0010")) 
or ((vector(j)(15 downto 12) = "0000") and (vector(j-2)(15 downto 12) = "0001")) then
   
	if (vector(j)(8 downto 6) = vector(j-2)(8 downto 6)) or 
		(vector(j)(8 downto 6) = vector(j-2)(11 downto 9)) then
		temp_cont2 <= '1';
	else 
		null;
   end if;
else
null;
end if;
end loop;
for j in 3 downto 3 loop
if ((vector(j)(15 downto 12) = "0000") and (vector(j-3)(15 downto 12) = "0010")) 
or ((vector(j)(15 downto 12) = "0000") and (vector(j-3)(15 downto 12) = "0001")) then
   
	if (vector(j)(8 downto 6) = vector(j-3)(8 downto 6)) or 
		(vector(j)(8 downto 6) = vector(j-3)(11 downto 9)) then
		temp_cont1 <= '1';
	else 
		null;
   end if;
else
null;
end if;
end loop;
	
end if;

end process;

P3 : process(vector)
begin
if vector /= (others => "0000000000000000") then
for j in 3 downto 1 loop
if ((vector(j)(15 downto 12) = "0010") and (vector(j-1)(15 downto 12) = "0000")) or
((vector(j)(15 downto 12) = "0001") and (vector(j-1)(15 downto 12) = "0000")) then
	
	if (vector(j)(5 downto 3) = vector(j-1)(8 downto 6)) or 
		(vector(j)(5 downto 3) = vector(j-1)(11 downto 9)) then
		temp_cont3 <= '1';
	else 
		null;
	end if;
else
null;
end if;	
end loop;

for j in 3 downto 2 loop
if ((vector(j)(15 downto 12) = "0010") and (vector(j-2)(15 downto 12) = "0000")) or
((vector(j)(15 downto 12) = "0001") and (vector(j-2)(15 downto 12) = "0000")) then
	
	if (vector(j)(5 downto 3) = vector(j-2)(8 downto 6)) or 
		(vector(j)(5 downto 3) = vector(j-2)(11 downto 9)) then
		temp_cont2 <= '1';
	else 
		null;
	end if;
else
null;
end if;	
end loop;

for j in 3 downto 3 loop

if ((vector(j)(15 downto 12) = "0010") and (vector(j-3)(15 downto 12) = "0000")) or
((vector(j)(15 downto 12) = "0001") and (vector(j-3)(15 downto 12) = "0000")) then
	
	if (vector(j)(5 downto 3) = vector(j-3)(8 downto 6)) or 
		(vector(j)(5 downto 3) = vector(j-3)(11 downto 9)) then
		temp_cont1 <= '1';
	else 
		null;
	end if;
else
null;
end if;	
end loop;
else 
null;
end if;

end process;

P4 : process(vector)
begin
if vector /= (others => "0000000000000000") then
for j in 3 downto 1 loop
if ((vector(j)(15 downto 12) = "0000") and (vector(j-2)(15 downto 12) = "0000")) then
	if (vector(j)(8 downto 6) = vector(j-1)(8 downto 6)) or 
		(vector(j)(8 downto 6) = vector(j-1)(11 downto 9)) then
		temp_cont3 <= '1';
	else 
		null;
	end if;
else
null;
end if;
end loop;

for j in 3 downto 2 loop
if ((vector(j)(15 downto 12) = "0000") and (vector(j-2)(15 downto 12) = "0000")) then
	if (vector(j)(8 downto 6) = vector(j-2)(8 downto 6)) or 
		(vector(j)(8 downto 6) = vector(j-2)(11 downto 9)) then
		temp_cont2 <= '1';
	else 
		null;
   end if;
else
null;
end if;
end loop;

for j in 3 downto 3 loop
if ((vector(j)(15 downto 12) = "0000") and (vector(j-3)(15 downto 12) = "0000")) then
	if (vector(j)(8 downto 6) = vector(j-3)(8 downto 6)) or 
		(vector(j)(8 downto 6) = vector(j-3)(11 downto 9)) then
		temp_cont1 <= '1';
	else 
		null;
   end if;
else
null;
end if;
end loop;
	
end if;

end process;

control1 <= temp_cont1;
control2 <= temp_cont2;
control3 <= temp_cont3;


end behav;