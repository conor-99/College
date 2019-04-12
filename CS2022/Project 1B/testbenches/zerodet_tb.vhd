-- Test bench for Zero Detector

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zerodet_tb is end zerodet_tb;

architecture behave of zerodet_tb is

	signal Clk_sig: std_logic := '0';
	signal data_sig: std_logic_vector (3 downto 0) := "0000";
	signal Z_sig: std_logic;
	
	component zerodet is
		port (
			Clk: in std_logic;
			data: in std_logic_vector (3 downto 0);
			Z: out std_logic
		);
	end component zerodet;

begin

	zerodet_inst: zerodet
	port map(
		Clk => Clk_sig,
		data => data_sig,
		Z => Z_sig
	);

	process is
	begin
		data_sig <= "1010";
		Clk_sig <= '0';
		wait for 10ns;
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		wait for 100ns;
		data_sig <= "1111";
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		wait for 100ns;
		data_sig <= "0000";
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		wait for 100ns;
		data_sig <= "0001";
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
	end process;

end behave;

