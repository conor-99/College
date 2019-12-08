-- Test bench for Program Counter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_tb is end pc_tb;

architecture behave of pc_tb is

	signal data_I_sig: std_logic_vector (15 downto 0) := x"0000";
	signal PL_sig: std_logic := '0';
	signal PI_sig: std_logic := '0';
	signal reset_sig: std_logic := '0';
	signal data_O_sig: std_logic_vector (15 downto 0);
	
	component pc is
		port (
			data_I: in std_logic_vector (15 downto 0);
			PL, PI, reset: in std_logic;
			data_O: out std_logic_vector (15 downto 0)
		);
	end component pc;

begin

	pc_inst: pc
	port map(
		data_I => data_I_sig,
		PL => PL_sig,
		PI => PI_sig,
		reset => reset_sig,
		data_O => data_O_sig
	);

	process is
	begin
		data_I_sig <= x"0002";
		PL_sig <= '0';
		PI_sig <= '0';
		reset_sig <= '1';
		wait for 5ns;
		reset_sig <= '0';
		PI_sig <= '1';
		wait for 5ns;
		PL_sig <= '1';
		wait for 5ns;
		reset_sig <= '1';
		wait for 5ns;
	end process;

end behave;
