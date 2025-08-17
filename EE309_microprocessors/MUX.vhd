library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

package MUX is

	component mux_0 is
		 Port (
			  alu3_c : in  std_logic_vector(15 downto 0);
			  pc2 : in  std_logic_vector(15 downto 0); 
			  alu2_c : in  std_logic_vector(15 downto 0);
			  mux1_out : in  std_logic_vector(15 downto 0);
			  c1_0, c0_0 : in std_logic;
			  mux0_out : out  std_logic_vector(15 downto 0) 
		 );
	end component mux_0;
	
	component mux_1 is
    Port (
        alu3_c : in  std_logic_vector(15 downto 0);
        rf_d2 : in  std_logic_vector(15 downto 0); 
        alu1_c : in  std_logic_vector(15 downto 0);
        c1_1, c0_1 : in std_logic;
        mux1_out : out  std_logic_vector(15 downto 0) 
    );
   end component mux_1;
	
	component mux_2 is
    Port (
		  none : in  std_logic_vector(2 downto 0);
        i_mem : in  std_logic_vector(2 downto 0);
        c0_2 : in std_logic;
        mux2_out : out  std_logic_vector(2 downto 0)
    );
   end component mux_2;
	
	component mux_3 is
    Port (
		  none : in  std_logic_vector(2 downto 0);
        i_mem : in  std_logic_vector(2 downto 0);
        c0_3 : in std_logic;
        mux3_out : out  std_logic_vector(2 downto 0)
    );
	end component mux_3;
	
	component mux_4 is
    Port (
        i_mem_1 : in  std_logic_vector(2 downto 0);
        i_mem_2 : in  std_logic_vector(2 downto 0); 
        i_mem_3 : in  std_logic_vector(2 downto 0);
        c1_4, c0_4 : in std_logic;
        mux4_out : out  std_logic_vector(2 downto 0) 
    );
	end component mux_4;
	
	component mux_5 is
    Port (
        exe_stage : in  std_logic_vector(15 downto 0);
        alu1_c : in  std_logic_vector(15 downto 0); 
        d_mem_d : in  std_logic_vector(15 downto 0);
        c1_5, c0_5 : in std_logic;
        mux5_out : out  std_logic_vector(15 downto 0) 
    );
	end component mux_5;
	
	component mux_6 is
    Port (
        rf_d1 : in  std_logic_vector(15 downto 0);
		  none : in  std_logic_vector(15 downto 0);
        rf_d2 : in  std_logic_vector(15 downto 0); 
        pc : in  std_logic_vector(15 downto 0);
        c1_6, c0_6 : in std_logic;
        mux6_out : out  std_logic_vector(15 downto 0) 
    );
	end component mux_6;
	
	component mux_7 is
    Port (
        rf_d2 : in  std_logic_vector(15 downto 0);
        compl : in  std_logic_vector(15 downto 0);
        se10 : in  std_logic_vector(15 downto 0);
        se7_1ls : in  std_logic_vector(15 downto 0);
        none : in  std_logic_vector(15 downto 0);
        two : in std_logic_vector(15 downto 0);  
        c2_7, c1_7, c0_7 : in std_logic;
        mux7_out : out  std_logic_vector(15 downto 0)
    );
	end component mux_7;
	
	component mux_8 is
    Port (
        alu1_c : in  std_logic_vector(15 downto 0);
        pc : in  std_logic_vector(15 downto 0); 
		  none : in  std_logic_vector(15 downto 0); 
        c1_8, c0_8 : in std_logic;
        mux8_out : out  std_logic_vector(15 downto 0) 
    );
	end component mux_8;

	component mux_9 is
    Port (
        carry : in  std_logic_vector(15 downto 0);
        se10_1ls : in  std_logic_vector(15 downto 0); 
        se7_1ls : in  std_logic_vector(15 downto 0);
		  none : in  std_logic_vector(15 downto 0);
        c1_9, c0_9 : in std_logic;  
        mux9_out : out  std_logic_vector(15 downto 0) 
    );	
	end component mux_9;
	
	
	component mux_10 is
    Port (
        alu1_c : in  std_logic_vector(15 downto 0);
        rf_d1 : in  std_logic_vector(15 downto 0);
        c0_10 : in std_logic;
        mux10_out : out  std_logic_vector(15 downto 0)
    );
	end component mux_10;

	component mux_11 is
    Port (
        ze7 : in  std_logic_vector(15 downto 0);
        alu3_c : in  std_logic_vector(15 downto 0);
        c0_11 : in std_logic;
        mux11_out : out  std_logic_vector(15 downto 0)
    );
	end component mux_11;

component mux_hlt is
    Port (
		  inp0 : in  std_logic_vector(47 downto 0);
        instr_and_PC : in  std_logic_vector(31 downto 0);
        HLT : in std_logic;
        mux_hlt_out : out  std_logic_vector(47 downto 0)
    );
end component mux_hlt;

-- component mux_bus is
-- Port (
--     d_mem_md_out : in  M_data;
--     rf_dm : in  M_data;
--     c0_12 : in std_logic;
--     c0_13 : in std_logic;
--     rf_d3_m : out  M_data;
--     d_mem_md_in : out  M_data
-- );
-- end component mux_bus;


	
	
end package MUX;
--#############

--MUX_0
library ieee;
use ieee.std_logic_1164.all;

entity mux_0 is
    Port (
        alu3_c : in  std_logic_vector(15 downto 0);
        pc2 : in  std_logic_vector(15 downto 0); 
        alu2_c : in  std_logic_vector(15 downto 0);
        mux1_out : in  std_logic_vector(15 downto 0);
        c1_0, c0_0 : in std_logic;
        mux0_out : out  std_logic_vector(15 downto 0) 
    );
end mux_0;

architecture exe of mux_0 is
begin
    process (alu3_c, pc2, alu2_c, mux1_out, c1_0, c0_0)
    begin
        case std_logic_vector'(c1_0 & c0_0) is
            when "11" =>
                mux0_out <= alu3_c; 
            when "00" =>
                mux0_out <= pc2; 
            when "10" =>
                mux0_out <= alu2_c; 
            when "01" =>
                mux0_out <= mux1_out; 
            when others =>
                mux0_out <= (others => '0');
        end case;
    end process;
end architecture exe;


--MUX_1
library ieee;
use ieee.std_logic_1164.all;

entity mux_1 is
    Port (
        alu3_c : in  std_logic_vector(15 downto 0);
        rf_d2 : in  std_logic_vector(15 downto 0); 
        alu1_c : in  std_logic_vector(15 downto 0);
        c1_1, c0_1 : in std_logic;
        mux1_out : out  std_logic_vector(15 downto 0) 
    );
end mux_1;

architecture exe of mux_1 is
begin
    process (alu3_c, rf_d2, alu1_c, c1_1, c0_1)
    begin
        case std_logic_vector'(c1_1 & c0_1) is
            when "01" =>
                mux1_out <= alu3_c; 
            when "10" =>
                mux1_out <= rf_d2; 
            when "11" =>
                mux1_out <= alu1_c; 
            when others =>
                mux1_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;

--MUX_2
library ieee;
use ieee.std_logic_1164.all;

entity mux_2 is
    Port (
		  none : in  std_logic_vector(2 downto 0);
        i_mem : in  std_logic_vector(2 downto 0);
        c0_2 : in std_logic;
        mux2_out : out  std_logic_vector(2 downto 0)
    );
end mux_2;

architecture exe of mux_2 is
begin
    process (i_mem, c0_2)
    begin
        case c0_2 is
            when '1' =>
                mux2_out <= i_mem; 
				when '0' =>
                mux2_out <= none; 
            when others =>
                mux2_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;

--MUX_3
library ieee;
use ieee.std_logic_1164.all;

entity mux_3 is
    Port (
		  none : in  std_logic_vector(2 downto 0);
        i_mem : in  std_logic_vector(2 downto 0);
        c0_3 : in std_logic;
        mux3_out : out  std_logic_vector(2 downto 0)
    );
end mux_3;

architecture exe of mux_3 is
begin
    process (i_mem, c0_3)
    begin
        case c0_3 is
            when '1' =>
                mux3_out <= i_mem; 
				when '0' =>
                mux3_out <= none; 
            when others =>
                mux3_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;


--MUX_4
library ieee;
use ieee.std_logic_1164.all;

entity mux_4 is
    Port (
        i_mem_1 : in  std_logic_vector(2 downto 0);
        i_mem_2 : in  std_logic_vector(2 downto 0); 
        i_mem_3 : in  std_logic_vector(2 downto 0);
        c1_4, c0_4 : in std_logic;
        mux4_out : out  std_logic_vector(2 downto 0) 
    );
end mux_4;

architecture exe of mux_4 is
begin
    process (i_mem_1, i_mem_2, i_mem_3, c1_4, c0_4)
    begin
        case std_logic_vector'(c1_4 & c0_4) is 
            when "00" =>
                mux4_out <= i_mem_1; 
            when "01" =>
                mux4_out <= i_mem_2; 
            when "10" =>
                mux4_out <= i_mem_3; 
            when others =>
                mux4_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;

--MUX_5
library ieee;
use ieee.std_logic_1164.all;

entity mux_5 is
    Port (
        exe_stage : in  std_logic_vector(15 downto 0);
        alu1_c : in  std_logic_vector(15 downto 0); 
        d_mem_d : in  std_logic_vector(15 downto 0);
        c1_5, c0_5 : in std_logic;
        mux5_out : out  std_logic_vector(15 downto 0) 
    );
end mux_5;

architecture exe of mux_5 is
begin
    process (exe_stage, alu1_c, d_mem_d, c1_5, c0_5)
    begin
        case std_logic_vector'(c1_5 & c0_5) is  
            when "00" =>
                mux5_out <= exe_stage; 
            when "10" =>
                mux5_out <= alu1_c; 
            when "11" =>
                mux5_out <= d_mem_d; 
            when others =>
                mux5_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;


--MUX_6
library ieee;
use ieee.std_logic_1164.all;

entity mux_6 is
    Port (
        rf_d1 : in  std_logic_vector(15 downto 0);
		  none : in  std_logic_vector(15 downto 0);
        rf_d2 : in  std_logic_vector(15 downto 0); 
        pc : in  std_logic_vector(15 downto 0);
        c1_6, c0_6 : in std_logic;
        mux6_out : out  std_logic_vector(15 downto 0) 
    );
end mux_6;

architecture exe of mux_6 is
begin
    process (rf_d1, none, rf_d2, pc, c1_6, c0_6)
    begin
        case std_logic_vector'(c1_6 & c0_6) is  
            when "00" =>
                mux6_out <= rf_d1; 
            when "10" =>
                mux6_out <= rf_d2;
					when "01" =>
                mux6_out <= none;
            when "11" =>
                mux6_out <= pc;  
            when others =>
                mux6_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;


--MUX_7
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_7 is
    Port (
        rf_d2 : in  std_logic_vector(15 downto 0);
        compl : in  std_logic_vector(15 downto 0);
        se10 : in  std_logic_vector(15 downto 0);
        se7_1ls : in  std_logic_vector(15 downto 0);
        none : in  std_logic_vector(15 downto 0);
        two : in std_logic_vector(15 downto 0);  
        c2_7, c1_7, c0_7 : in std_logic;
        mux7_out : out  std_logic_vector(15 downto 0)
    );
end mux_7;

architecture exe of mux_7 is
begin
    process (rf_d2, compl, se10, se7_1ls, none, c2_7, c1_7, c0_7)
    begin
        case std_logic_vector'(c2_7 & c1_7 & c0_7) is  
            when "000" =>
                mux7_out <= rf_d2; 
            when "001" =>
                mux7_out <= compl; 
            when "010" =>
                mux7_out <= se10; 
            when "011" =>
                mux7_out <= se7_1ls; 
            when "100" =>
                mux7_out <= none; 
            when "101" =>
                mux7_out <= two;  
            when others =>
                mux7_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;


--MUX_8
library ieee;
use ieee.std_logic_1164.all;

entity mux_8 is
    Port (
        alu1_c : in  std_logic_vector(15 downto 0);
        pc : in  std_logic_vector(15 downto 0); 
		  none : in  std_logic_vector(15 downto 0); 
        c1_8, c0_8 : in std_logic;
        mux8_out : out  std_logic_vector(15 downto 0) 
    );
end mux_8;

architecture exe of mux_8 is
begin
    process (alu1_c, pc, none, c1_8, c0_8)  
    begin
        case std_logic_vector'(c1_8 & c0_8) is  
            when "01" =>
                mux8_out <= pc; 
            when "00" =>
                mux8_out <= alu1_c;
				 when "10" =>
                mux8_out <= none; 	 
            when others =>
                mux8_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;


--MUX_9
library ieee;
use ieee.std_logic_1164.all;

entity mux_9 is
    Port (
        carry : in  std_logic_vector(15 downto 0);
        se10_1ls : in  std_logic_vector(15 downto 0); 
        se7_1ls : in  std_logic_vector(15 downto 0);
		  none : in  std_logic_vector(15 downto 0);
        c1_9, c0_9 : in std_logic;  
        mux9_out : out  std_logic_vector(15 downto 0) 
    );
end mux_9;

architecture exe of mux_9 is
begin
    process (carry, se10_1ls, se7_1ls, c1_9, c0_9)  
    begin
        case std_logic_vector'(c1_9 & c0_9) is  
            when "00" =>
                mux9_out <= carry;  
            when "01" =>
                mux9_out <= se10_1ls;  
            when "10" =>
                mux9_out <= se7_1ls; 
				when "11" =>
                mux9_out <= none; 	 
            when others =>
                mux9_out <= (others => '0');  
        end case;
    end process;
end architecture exe;

--MUX_10
library ieee;
use ieee.std_logic_1164.all;

entity mux_10 is
    Port (
        alu1_c : in  std_logic_vector(15 downto 0);
        rf_d1 : in  std_logic_vector(15 downto 0);
        c0_10 : in std_logic;
        mux10_out : out  std_logic_vector(15 downto 0)
    );
end mux_10;

architecture exe of mux_10 is
begin
    process (alu1_c, rf_d1, c0_10)
    begin
        case c0_10 is  
            when '0' =>
                mux10_out <= alu1_c;  
            when '1' =>
                mux10_out <= rf_d1;  
            when others =>
                mux10_out <= (others => '0');  
        end case;
    end process;
end architecture exe;

--MUX_11
library ieee;
use ieee.std_logic_1164.all;

entity mux_11 is
    Port (
        ze7 : in  std_logic_vector(15 downto 0);
        alu3_c : in  std_logic_vector(15 downto 0);
        c0_11 : in std_logic;
        mux11_out : out  std_logic_vector(15 downto 0)
    );
end mux_11;

architecture exe of mux_11 is
begin
    process (ze7, alu3_c, c0_11)
    begin
        case c0_11 is  
            when '0' =>
                mux11_out <= ze7;  
            when '1' =>
                mux11_out <= alu3_c;  
            when others =>
                mux11_out <= (others => '0');  
        end case;
    end process;
end architecture exe;

--HLT
library ieee;
use ieee.std_logic_1164.all;

entity mux_hlt is
    Port (
		  inp0 : in  std_logic_vector(47 downto 0);
        instr_and_PC : in  std_logic_vector(31 downto 0);
        HLT : in std_logic;
        mux_hlt_out : out  std_logic_vector(47 downto 0)
    );
end mux_hlt;

architecture exe of mux_htl is
begin
    process (inp0, instr, HLT)
    begin
        case HLT is
            when '1' =>
                mux_hlt_out <= inp0; 
				when '0' =>
                mux_hlt_out(47 downto 16) <= instr_and_PC;
					 mux_hlt_out(15 downto 0) <= "0000000000000000";
            when others =>
                mux_hlt_out <= (others => '0'); 
        end case;
    end process;
end architecture exe;


--MUX12 + MUX13 bus 
-- library ieee;
-- use ieee.std_logic_1164.all;
-- use work.pkg.all;

-- entity mux_bus is
--     Port (
--         d_mem_md_out : in  M_data;
--         rf_dm : in  M_data;
--         c0_12 : in std_logic;
--         c0_13 : in std_logic;
--         rf_d3_m : out  M_data;
--         d_mem_md_in : out  M_data
--     );
-- end mux_bus;

-- architecture exe of mux_bus is
-- begin
--     process (d_mem_md_out, rf_dm, c0_12, c0_13)
--     begin
--         case std_logic_vector'(c0_12 & c0_13) is  
--             when "00" =>
--                 rf_d3_m <= d_mem_md_out;
--                 d_mem_md_in <= (others => (others => 'Z'));
--             when "11" =>
--                 rf_d3_m <= (others => (others => 'Z'));
--                 d_mem_md_in <= rf_dm;
--             when others =>
--                 rf_d3_m <= (others => (others => 'Z'));
--                 d_mem_md_in <= (others => (others => 'Z'));
--         end case;
--     end process;
-- end architecture exe;
