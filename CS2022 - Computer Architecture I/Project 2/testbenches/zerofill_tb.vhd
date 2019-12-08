-- Test bench for Zerofill

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zerofill_tb is end zerofill_tb;

architecture behave of zerofill_tb is

	signal SB_I_sig: std_logic_vector (2 downto 0) := "000";
	signal SB_O_sig: std_logic_vector (15 downto 0);
	
	component zerofill is
		port (
			SB_I: in std_logic_vector (2 downto 0);
			SB_O: out std_logic_vector (15 downto 0)
		);
	end component zerofill;

begin

	zerofill_inst: zerofill
	port map(
		SB_I => SB_I_sig,
		SB_O => SB_O_sig
	);

	process is
	begin
		SB_I_sig <= "100";
		wait for 100ns;
		SB_I_sig <= "010";
		wait for 100ns;
	end process;

end behave;