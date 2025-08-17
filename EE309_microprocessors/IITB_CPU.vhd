library ieee;
use IEEE.std_logic_1164.all;
library work;
use work.pkg.all;
use work.MUX.all;
use ieee.numeric_std.all;

entity IITB_CPU is 
port (clk, reset: in std_logic;
		Instr_out: out std_logic_vector(15 downto 0);
		PC_out: out std_logic_vector(15 downto 0)
);
end entity;

architecture struct of IITB_CPU is

component MEM_WB_PR is
	port(clk, reset: in std_logic;
	PR_prev: in std_logic_vector(113 downto 0);
	D_MEM_D_out: in std_logic_vector(15 downto 0);
	PR_to_WB: out std_logic_vector(111 downto 0)
	);
end component;

component D_MEM is 
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
end component;

component RF_W_writer is 
port(clk,reset: in std_logic;
	  RF_W_inp: in std_logic;
	  Cprev: in std_logic;
	  Zprev: in std_logic;
	  Opcode: in std_logic_vector(3 downto 0);
	  lsb_3: in std_logic_vector(2 downto 0);
	  RF_W: out std_logic);
end component;

component EX_MEM_PR is
port(clk, reset: in std_logic;
     PR_prev: in std_logic_vector(95 downto 0);
	  Zprev,Cprev: in std_logic;
	  result_of_EX: in std_logic_vector(15 downto 0);
	  ALU1_C: in std_logic_vector(15 downto 0);
	  PR_to_MEM: out std_logic_vector(113 downto 0)
	  );
end component;

component OR_EX_PR is
port(clk, reset: in std_logic;
     PR_prev: in std_logic_vector(79 downto 0);
	  RF_D1,RF_D2: in std_logic_vector(15 downto 0);
	  PR_to_EX: out std_logic_vector(95 downto 0)
	  );
end component;

component C_Z_writer is 
	port(clk,reset,C,Z: in std_logic;
		  Zprev,Cprev: out std_logic
		  );
end component;

component ALU is 
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
end component;

component cacheSM is 
	port(clk, reset: in std_logic;
		  OPcode_from_ID_OR: in std_logic_vector(3 downto 0);
		  RF_DM: in M_data;
		  D_MEM_MD_in: out M_data
	);
end component;

component cacheLM is
	port( clk,reset: in std_logic;
			OPcode_from_EX_MEM_PR: in std_logic_vector(3 downto 0);
			D_MEM_MD_out: in M_data;
			RF_D3_M: out M_data
	);
end component;

component OpR is
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
end component;

component ID_OR_PR is
port(clk, reset: in std_logic;
     PR_prev: in std_logic_vector(47 downto 0);
	  CNTRL_SIGNS: in std_logic_vector(31 downto 0);
	  PR_to_OR: out std_logic_vector(79 downto 0)
	  );
end component;

component IF_ID_PR is
port(clk, reset: in std_logic;
	  INSTR: in std_logic_vector(15 downto 0);
	  PC: in std_logic_vector(15 downto 0);
	  PC_plus_2: in std_logic_vector(15 downto 0);
	  PR_to_ID: out std_logic_vector(47 downto 0)
	  );
end component;

component FDE is
port(clk, reset: in std_logic;
	  opcode : in std_logic_vector(3 downto 0);
     lsb : in std_logic_vector(2 downto 0);
	  cont_signal : out std_logic_vector(31 downto 0));
end component FDE;

component ALU_2 is
    port(
        clk,reset: in  std_logic;
        A_in     : in  std_logic_vector(15 downto 0);
        result   : out std_logic_vector(15 downto 0)
    );
end component;

component I_MEM is 
	port (clk, reset: in std_logic;
			PC: in std_logic_vector(15 downto 0);
			Instr_and_PC: out std_logic_vector(31 downto 0);
			Instr: out std_logic_vector(15 downto 0)
			);
end component;

component MAIN_DC is
port(clk, reset, C1, Z1: in std_logic;
		instr: in std_logic_vector(15 downto 0);
		C1_0, C0_0, C1_1, C0_1, BR_W, IP_W, HLT: out std_logic
	  );
end component;

-- signal is always named from the output side
signal PR_to_WB: std_logic_vector(111 downto 0);
signal PR_MEM_PR: std_logic_vector(113 downto 0);
signal PR_to_EX: std_logic_vector(95 downto 0);
signal PR_to_OR: std_logic_vector(79 downto 0);
signal PR_to_ID,ALL_ZERO, mux_hlt_output: std_logic_vector(47 downto 0);

signal ALU1_C, ALU2_C_out, ALU3_C_alu_out, result_of_EX, D_out, mux10, RF_D1, RF_D2, PC_outer_sig, I_MEM_Instr_out: std_logic_vector(15 downto 0);
signal MD_out, cacheSM_out, cacheLM_out, RF_DM: M_data;
signal RF_W, C0_13, C0_12, CARRY, ZERO, Zprev, Cprev, CARRY1, ZERO1: std_logic;
signal MAIN_DC_C1_0, MAIN_DC_C0_0, MAIN_DC_C1_1, MAIN_DC_C0_1, MAIN_DC_BR_W, MAIN_DC_IP_W, MAIN_DC_HLT: std_logic; 
signal FDE_out, I_MEM_instr_and_PC_out: std_logic_vector(31 downto 0);

begin
--MEM STAGE

MEM_WB_PR_file: MEM_WB_PR port map (clk, reset, PR_MEM_PR, D_out, PR_to_WB);
RF_W_writer_file: RF_W_writer port map (clk, reset, PR_MEM_PR(1), PR_MEM_PR(112), PR_MEM_PR(113),
													 PR_MEM_PR(111 downto 108), PR_MEM_PR(99 downto 97), RF_W);

D_MEM_file: D_MEM  port map (clk, reset, mux10, PR_MEM_PR(103 downto 96), cacheSM_out,
									  PR_MEM_PR(63 downto 48), PR_MEM_PR(6), PR_MEM_PR(5), PR_MEM_PR(4), D_out, MD_out);

mux10_file: mux_10 port map (PR_MEM_PR(79 downto 64), PR_MEM_PR(63 downto 48), PR_MEM_PR(7), mux10);

cacheSM_file: cacheSM port map (clk, reset, PR_to_OR(79 downto 76), RF_DM, cacheSM_out);
cacheLM_file: cacheLM port map (clk, reset, PR_MEM_PR(111 downto 108), MD_out, cacheLM_out);

EX_MEM_PR_file: EX_MEM_PR port map (clk, reset, PR_to_EX, Zprev ,Cprev ,result_of_EX ,ALU1_C, PR_MEM_PR);

-- EX STAGE

ALU_file: ALU port map (clk, reset, PR_to_EX(79 downto 64), PR_to_EX(63 downto 48), PR_to_EX(47 downto 32), 
								PR_to_EX(95 downto 80), PR_to_EX(24), PR_to_EX(23), PR_to_EX(22), PR_to_EX(21),
								PR_to_EX(20), PR_to_EX(19), PR_to_EX(18), PR_to_EX(17), PR_to_EX(16),
								PR_to_EX(15), PR_to_EX(14), PR_to_EX(13), PR_to_EX(12), PR_to_EX(11),
								PR_to_EX(10), PR_to_EX(9), PR_to_EX(8), PR_to_EX(25), PR_to_EX(3),
								result_of_EX, ALU1_C, ALU3_C_alu_out, CARRY , ZERO, CARRY1, ZERO1);
C_Z_writer_file: C_Z_writer port map (clk,reset, CARRY, ZERO, Zprev, Cprev);

OR_EX_PR_file: OR_EX_PR port map (clk, reset, PR_to_OR, RF_D1, RF_D2, PR_to_EX);

-- OR stage

OpR_file: OpR port map (clk, reset, MAIN_DC_C1_0, MAIN_DC_C0_0, MAIN_DC_C1_1, MAIN_DC_C0_1, PR_to_OR(31), PR_to_OR(30),
								PR_to_WB(29), PR_to_WB(28), PR_to_WB(27), PR_to_WB(26), MAIN_DC_IP_w, MAIN_DC_BR_W, 
								PR_to_WB(1), PR_to_WB(0),
								ALU3_C_alu_out, PR_to_OR(47 downto 32), ALU2_C_out, RF_D2, ALU1_C,
								PR_to_OR(75 downto 73), PR_to_OR(72 downto 70), PR_to_WB(69 downto 67), PR_to_WB(72 downto 70),
								PR_to_WB(75 downto 73), 
								PR_to_WB(95 downto 48),
								cacheLM_out, 
								PR_to_OR(70 downto 64),
								RF_D1, RF_D2,
								RF_DM, PC_outer_sig);
								
MAIN_DC_file: MAIN_DC port map (clk, reset, CARRY1, ZERO1, I_MEM_Instr_out, MAIN_DC_C1_0, MAIN_DC_C0_0, 
											MAIN_DC_C1_1, MAIN_DC_C0_1, MAIN_DC_BR_W, MAIN_DC_IP_W, MAIN_DC_HLT);


ID_OR_PR_file: ID_OR_PR port map (clk, reset, PR_to_ID, FDE_out, PR_to_OR);

-- ID stage

FDE_file : FDE port map (clk, reset, PR_to_ID(47 downto 44), PR_to_ID(34 downto 32), FDE_out);

IF_ID_PR_file: IF_ID_PR port map (clk, reset, mux_hlt_output, ALU2_C_out, PR_to_ID);


-- IF stage
ALL_ZERO <= (others => '0');

ALU2_file: ALU_2 port map (clk, reset, PC_outer_sig, ALU2_C_out);
I_MEM_file: I_MEM port map (clk, reset, PC_outer_sig, I_MEM_instr_and_PC_out, I_MEM_Instr_out);
mux_hlt_file: mux_hlt port map (ALL_ZERO, I_MEM_instr_and_PC_out, MAIN_DC_HLT, mux_hlt_output);


end architecture;