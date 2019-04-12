-- Test bench for Zero Detector

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zerodet_tb is end zerodet_tb;

architecture behave of zerodet_tb is

	signal data_sig: std_logic_vector (3 downto 0) := "0000";
	signal Z_sig: std_logic;
	
	component zerodet is
		port (
			data: in std_logic_vector (3 downto 0);
			Z: out std_logic
		);
	end component zerodet;

begin

	zerodet_inst: zerodet
	port map(
		data => data_sig,
		Z => Z_sig
	);

	process is
	begin
		data_sig <= "1010";
		wait for 100ns;
		data_sig <= "1111";
		wait for 100ns;
		data_sig <= "0000";
		wait for 100ns;
		data_sig <= "0001";
		wait for 100ns;
	end process;

end behave;

