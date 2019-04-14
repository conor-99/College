-- Test bench for Instruction Register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inst_reg_tb is end inst_reg_tb;

architecture behave of inst_reg_tb is

	signal ins_I_sig: std_logic_vector (15 downto 0) := x"0000";
	signal IL_sig: std_logic := '0';
	signal DR_sig, SA_sig, SB_sig: std_logic_vector (2 downto 0);
	signal op_O_sig: std_logic_vector (7 downto 0);
	
	component inst_reg is
		port (
			ins_I: in std_logic_vector (15 downto 0);
			IL: in std_logic;
			DR, SA, SB: out std_logic_vector (2 downto 0);
			op_O: out std_logic_vector (7 downto 0)
		);
	end component inst_reg;

begin

	inst_reg_inst: inst_reg
	port map(
		ins_I => ins_I_sig,
		IL => IL_sig,
		DR => DR_sig,
		SA => SA_sig,
		SB => SB_sig,
		op_O => op_O_sig
	);

	process is
	begin
		ins_I_sig <= x"DEAD";
		IL_sig <= '1';
		wait for 100ns;
		IL_sig <= '0';
	end process;

end behave;
