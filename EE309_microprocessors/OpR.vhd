library ieee;
use IEEE.std_logic_1164.all;
library work;
use work.pkg.all;
use work.MUX.all;
use ieee.numeric_std.all;

entity OpR is
	port (clk, reset: in std_logic;
			C1_0, C0_0,
			C1_1, C0_1,
			C0_2, C0_3,
			C1_4, C0_4,
			C1_5, C0_5,
			IP_w, BR_W, RF_W, RF_M: in std_logic;
			ALU3_C, PC_plus_2, ALU2_C, RF_D2, ALU1_C: in std_logic_vector(15 downto 0);
			Instr_9_to_11_A1, Instr_6_to_8_A2, Instr_3_to_5, Instr_6_to_8, Instr_9_to_11: in std_logic_vector(2 downto 0);
			MEM_WB_95_to_48: std_logic_vector(47 downto 0);
			RF_D3_M: in M_data;
			RF_A3_M: in std_logic_vector(7 downto 0);
			RF_D1_OPR_out, RF_D2_OPR_out: out std_logic_vector(15 downto 0);
			RF_DM_OPR_out: out M_data;
			PC_outer: out std_logic_vector(15 downto 0)
			);
end entity;

architecture struct of OpR is 

component R0_prog is
	 port(clk, reset:in std_logic;
			RF_R0_W: in std_logic_vector(15 downto 0);
			R0_prog_W: in std_logic;
			R0_prog: out std_logic_vector(15 downto 0)
	 );
end component;

component RF is
	port (clk, reset: in std_logic;
			IP_w, RF_W, RF_M: in std_logic;
			RF_IP_W, RF_D3, R0_prog: in std_logic_vector(15 downto 0);
			RF_A1, RF_A2, RF_A3: in std_logic_vector(2 downto 0);
			RF_D3_M: in M_data;
			RF_A3_M: in std_logic_vector(7 downto 0);
			R0_prog_W: out std_logic;
			RF_D1, RF_D2, R0_prog_RF_to_R0: out std_logic_vector(15 downto 0);
			RF_DM: out M_data;
			RF_IP_out: out std_logic_vector(15 downto 0)
			);
end component;

signal M0_out,M1_out,M5_out, BR_out, starting_PC: std_logic_vector(15 downto 0);
signal M2_out,M3_out,M4_out: std_logic_vector(2 downto 0);
signal R0_prog_W_sig: std_logic;
signal R0_prog_RF_to_R0, R0_prog_R0_to_RF: std_logic_vector(15 downto 0);
signal BR: std_logic_vector(15 downto 0);

begin
PC_outer <= starting_PC;
R0_prog_file: R0_prog port map (clk, reset, R0_prog_RF_to_R0, R0_prog_W_sig, R0_prog_R0_to_RF);
RF_file: RF port map (clk, reset, IP_W, RF_W, RF_M, M0_out, M5_out, R0_prog_R0_to_RF, 
							 M2_out, M3_out, M4_out, RF_D3_M, RF_A3_M, R0_prog_W_sig, RF_D1_OPR_out, 
							 RF_D2_OPR_out, R0_prog_RF_to_R0, RF_DM_OPR_out, starting_PC);
							 
mux0_file: mux_0 port map (ALU3_C, BR_out, ALU2_C, M1_out, C1_0, C0_0, M0_out);
mux1_file: mux_1 port map (ALU3_C, RF_D2, ALU1_C, C1_1, C0_1, M1_out);
mux2_file: mux_2 port map ("ZZZ", Instr_9_to_11_A1, C0_2, M2_out);
mux3_file: mux_3 port map ("ZZZ", Instr_6_to_8_A2, C0_3, M3_out);
mux4_file: mux_4 port map (Instr_3_to_5, Instr_6_to_8, Instr_9_to_11, C1_4, C0_4, M4_out);
mux5_file: mux_5 port map (MEM_WB_95_to_48(47 downto 32),MEM_WB_95_to_48(31 downto 16),
									MEM_WB_95_to_48(15 downto 0), C1_5, C0_5, M5_out);

process(PC_plus_2)
begin
if(BR_W = '1') then
	BR <= PC_plus_2;
end if;
end process;
end architecture;