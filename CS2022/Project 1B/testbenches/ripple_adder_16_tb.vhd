-- Test bench for 16-bit Ripple Adder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder_16_tb is end ripple_adder_16_tb;

architecture behave of ripple_adder_16_tb is

	signal B_sig, A_sig: std_logic_vector (15 downto 0) := "0000000000000000";
	signal CI_sig: std_logic := '0';
	signal S_sig: std_logic_vector (15 downto 0);
	signal CO_sig, V_sig: std_logic;
	
	component ripple_adder_16 is
		port (
			B, A: in std_logic_vector (15 downto 0);
			CI: in std_logic;
			S: out std_logic_vector (15 downto 0);
			CO, V: out std_logic
		);
	end component ripple_adder_16;

begin

	ripple_adder_16_inst: ripple_adder_16
	port map(
		B => B_sig,
		A => A_sig,
		CI => CI_sig,
		S => S_sig,
		CO => CO_sig,
		V => V_sig
	);

	process is
	begin
		
		A_sig <= "0000000000001000";
		B_sig <= "0000000000001000";
		CI_sig <= '1';

		wait for 100ns;

		A_sig <= "1111111111111111";
		B_sig <= "0000000000000001";
		CI_sig <= '0';

		wait for 100ns;

		A_sig <= "0000000001010100";
		B_sig <= "0000000010101010";
		CI_sig <= '1';

		wait for 100ns;

	end process;

end behave;
