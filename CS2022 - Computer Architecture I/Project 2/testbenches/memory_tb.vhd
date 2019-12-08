-- Test bench for Memory

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memory_tb is end memory_tb;

architecture behave of memory_tb is

	signal data_I_sig: std_logic_vector (15 downto 0) := x"0000";
	signal addr_I_sig: std_logic_vector (15 downto 0) := x"0000";
	signal MW_sig: std_logic := '0';
	signal data_O_sig: std_logic_vector (15 downto 0);
	
	component memory is
		port (
			data_I, addr_I: in std_logic_vector (15 downto 0);
			MW: in std_logic;
			data_O: out std_logic_vector (15 downto 0)
		);
	end component memory;

begin

	memory_inst: memory
	port map(
		data_I => data_I_sig,
		addr_I => addr_I_sig,
		MW => MW_sig,
		data_O => data_O_sig
	);

	process is
	begin
		data_I_sig <= x"0000";
		addr_I_sig <= x"0001";
		MW_sig <= '0';
		wait for 100ns;
		addr_I_sig <= x"0002";
		wait for 100ns;
		data_I_sig <= x"FFFF";
		addr_I_sig <= x"0000";
		MW_sig <= '1';
		wait for 100ns;
		MW_sig <= '0';
		wait for 100ns;
	end process;

end behave;
