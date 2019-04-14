-- Test bench for Processor

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity processor_tb is end processor_tb;

architecture behave of processor_tb is

	signal Clk_sig: std_logic := '0';
	signal reset_sig: std_logic := '0';
	signal PC_O_sig: std_logic_vector (15 downto 0);
	signal proc_O_sig: std_logic_vector (15 downto 0);
	
	component processor is
		port (
			Clk, reset: in std_logic;
			PC_O, proc_O: out std_logic_vector (15 downto 0)
		);
	end component processor;

begin

	processor_inst: processor
	port map(
		Clk => Clk_sig,
		reset => reset_sig,
		PC_O => PC_O_sig,
		proc_O => proc_O_sig
	);

	process is
	begin
		reset_sig <= '1';
		wait for 100ns;
		reset_sig <= '0';
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
	end process;

end behave;
