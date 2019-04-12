-- Test bench for Shifter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter_tb is end shifter_tb;

architecture behave of shifter_tb is

	signal H_sig: std_logic_vector (1 downto 0) := "00";
	signal data_B_sig: std_logic_vector (15 downto 0) := "0000000000000000";
	signal data_O_sig: std_logic_vector (15 downto 0);
	
	component shifter is
		port (
			H: in std_logic_vector (1 downto 0);
			data_B: in std_logic_vector (15 downto 0);
			data_O: out std_logic_vector (15 downto 0)
		);
	end component shifter;

begin

	shifter_inst: shifter
	port map(
		H => H_sig,
		data_B => data_B_sig,
		data_O => data_O_sig
	);

	process is
	begin
		data_B_sig <= "1111111111111111";
		H_sig <= "00";
		wait for 100ns;
		H_sig <= "01";
		wait for 100ns;
		H_sig <= "10";
		wait for 100ns;
		H_sig <= "11";
		wait for 100ns;
	end process;

end behave;

