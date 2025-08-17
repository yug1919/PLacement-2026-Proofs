library ieee;
use IEEE.std_logic_1164.all;
library work;
use work.pkg.all;
use ieee.numeric_std.all;

entity D_MEM is 
	port (clk: in std_logic;
			reset: in std_logic;
			addr: in std_logic_vector (15 downto 0);
			NUM: in std_logic_vector(7 downto 0);
			MD_in: in M_data;
			D_in: in std_logic_vector(15 downto 0);
			DMEM_W, DMEM_M, Is_none: in std_logic;
			D_out: out std_logic_vector(15 downto 0);
			MD_out: out M_data	
			);
end entity;

architecture struct of D_MEM is 

signal memory: D_array;
signal num_reg: integer;
												
signal D_MEM_CNTRL: std_logic_vector(2 downto 0);--[is_none, D.mem_W, D.mem_M]

signal sig_MD_out: M_data;
signal sig_D_out: std_logic_vector(15 downto 0);

begin
D_MEM_CNTRL(0) <= DMEM_M;
D_MEM_CNTRL(1) <= DMEM_W;
D_MEM_CNTRL(2) <= Is_none;

process(clk, NUM, addr, MD_in, D_in, reset)
variable i,upper_limit: integer := 0;
begin
	
	for i in 0 to 7 loop
		if (NUM(i)= '1') then 
			num_reg <= num_reg + 1;
		end if;
	end loop;

if (D_MEM_CNTRL(2)='0') then 	
	if (D_MEM_CNTRL(1)='1') then
		if(D_MEM_CNTRL(0)='1') then
			--MULTIPLE WRITE	
			i := to_integer(unsigned(addr));
			i := i-1;
			
			for j in 0 to 7 loop
				exit when j >= num_reg;   -- used when non-constant right bound
				memory(i+j) <= MD_in(j);
			end loop;
		else 
			--SINGLE WRITE
			memory(to_integer(unsigned(addr))-1) <= D_in;
		end if;
	else 
		if(D_MEM_CNTRL(0)='1') then
			--MULTIPLE READ	
			i := to_integer(unsigned(addr));
			i := i-1;
			
			for j in 0 to 7 loop
				exit when j >= num_reg;
				sig_MD_out(j) <= memory(i+j);
			end loop;
			for j in 0 to 7 loop
			if (j< num_reg) then                   -- used when non-constant left bound
			else	sig_MD_out(j) <= (others => '0');
			end if;
			end loop;
		else 
			--SINGLE READ
			sig_D_out <= memory(to_integer(unsigned(addr))-1);
		end if;
	end if;
else 
end if;

if (reset = '1') then
	MD_out <= (others => (others =>'0'));
	D_out <= (others => '0');
elsif (clk ='1' and clk'event) then
	MD_out <= sig_MD_out;
	D_out <= sig_D_out;
end if;

end process;
end architecture;