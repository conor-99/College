-- Test bench for Extend

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extend_tb is end extend_tb;

architecture behave of extend_tb is

	signal DR_sig: std_logic_vector (2 downto 0) := "000";
	signal SB_sig: std_logic_vector (2 downto 0) := "000";
	signal ext_O_sig: std_logic_vector (15 downto 0);
	
	component extend is
		port (
			DR, SB: in std_logic_vector (2 downto 0);
			ext_O: out std_logic_vector (15 downto 0)
		);
	end component extend;

begin

	extend_inst: extend
	port map(
		DR => DR_sig,
		SB => SB_sig,
		ext_O => ext_O_sig
	);

	process is
	begin
		DR_sig <= "100";
		SB_sig <= "110";
		wait for 100ns;
		DR_sig <= "010";
		SB_sig <= "001";
		wait for 100ns;
	end process;

end behave;
