library ieee;
use IEEE.std_logic_1164.all;
library work;
use work.MUX.all;
use ieee.numeric_std.all;

entity ALU is 
port (clk, reset, carry: in std_logic;
		RF_D1,RF_D2, PC, Instr: in std_logic_vector(15 downto 0);
		C1_6, C0_6, 
		C2_7,C1_7, C0_7,
		C1_A1,C0_A1,
		C1_w, Z1_W,
		C1_8, C0_8, 
		C1_9, C0_9, 
		C1_A3, C0_A3,
		C_W, Z_W,
		C0_11, Is_CEC1: in std_logic;
		result_of_EX, ALU1_C, ALU3_C: out std_logic_vector(15 downto 0);
		C,Z,C1,Z1: out std_logic
);
end entity;

architecture struct of ALU is 

component ALU_1_3 is
    port(
        reset    : in  std_logic;
		  C1_A     : in  std_logic;
        C0_A     : in  std_logic;
        A_in     : in  std_logic_vector(15 downto 0);
        B_in     : in  std_logic_vector(15 downto 0);
        result   : out std_logic_vector(15 downto 0);
        carry_out: out std_logic;
        zero_out : out std_logic
    );
end component;

component COMP is
    port(input_no : in  std_logic_vector(15 downto 0);
        output_no: out std_logic_vector(15 downto 0)
    );
end component;

component SE7_1LS is
    port(
        input_no : in  std_logic_vector(8 downto 0);
        SE7_LS  : out std_logic_vector(15 downto 0)
    );
end component;

component SE10 is
    port(
        input_no    : in  std_logic_vector(5 downto 0);
        sign_exed_10: out std_logic_vector(15 downto 0)
    );
end component;

component SE10_1LS is
    port(
        input_no : in  std_logic_vector(5 downto 0);
        SE10_LS  : out std_logic_vector(15 downto 0)
    );
end component;

component ZE7 is
    port(input_no    : in  std_logic_vector(8 downto 0);
        zero_exed_7 : out std_logic_vector(15 downto 0)
    );
end component;

signal C3,Z3,C11,Z11: std_logic;

signal COMP_out, SE10_out,
		 SE7_1LS_out,SE10_1LS_out,
		 ZE7_out: std_logic_vector(15 downto 0);
	
signal ALU1_A, ALU1_B, ALU1_C_sig, ALU3_C_sig, ALU3_A, ALU3_B, result_of_EX_sig: std_logic_vector(15 downto 0);
signal i: integer;
begin

ALU1: ALU_1_3 port map(reset, C1_A1, C0_A1, ALU1_A, ALU1_B, ALU1_C_sig, C11, Z11);
ALU3: ALU_1_3 port map(reset, C1_A3, C0_A3, ALU3_A, ALU3_B, ALU3_C_sig, C3, Z3);

COMP_file: COMP port map (RF_D2, COMP_out);

SE10_file: SE10 port map (Instr(5 downto 0), SE10_out);

SE7_1LS_file: SE7_1LS port map (Instr(8 downto 0), SE7_1LS_out);

SE10_1LS_file: SE10_1LS port map (Instr(5 downto 0), SE10_1LS_out);

ZE7_file: ZE7 port map (Instr(8 downto 0),ZE7_out);

mux6_file: mux_6 port map (RF_D1, "ZZZZZZZZZZZZZZZZ" , RF_D2, PC, C1_6, C0_6, ALU1_A);
mux7_file: mux_7 port map (RF_D2, COMP_out, SE10_out, SE7_1LS_out, "ZZZZZZZZZZZZZZZZ", "0000000000000010", C2_7, C1_7, C0_7, ALU1_B);
mux8_file: mux_8 port map (ALU3_C_sig, PC, "ZZZZZZZZZZZZZZZZ", C1_8, C0_8, ALU3_A);

carry_to_int: process(carry)
begin
if(carry = '1') then
i <= 1;
else 
i <= 0;
end if;
end process;

mux9_file: mux_9 port map (std_logic_vector(to_unsigned(i,16)), SE10_1LS_out, SE7_1LS_out, "ZZZZZZZZZZZZZZZZ", C1_9, C0_9, ALU3_B);
mux11_file: mux_11 port map (ZE7_out, ALU3_C_sig, C0_11, result_of_EX_sig);


process(Is_CEC1, C_W, Z_W, C1_W, Z1_W)
begin
	if(reset = '0') then
		if(clk ='1' and clk'event) then
			if(Is_CEC1 = '1' and C1_W = '1' and C_W = '1') then 
				C <= C11;
			elsif(C_W = '1') then
				C <= C3;
			else
			end if;
			
			if(Is_CEC1 = '1' and Z1_W = '1' and Z_W = '1') then 
				Z <= Z11;
			elsif(Z_W = '1') then
				Z <= Z3;
			else
			end if;
			ALU1_C <= ALU1_C_sig;
			ALU3_C <= ALU3_C_sig;
			result_of_EX <= result_of_EX_sig;
			C1 <= C11;
			Z1 <= Z11;
		end if;
	else 
	ALU1_C <= "0000000000000000" ;
	ALU3_C <= "0000000000000000" ;
	result_of_EX <= "0000000000000000";
	C <= '0';
	Z <= '0';
	C1 <= '0';
	Z1 <= '0';
	end if;
end process;
end architecture;

