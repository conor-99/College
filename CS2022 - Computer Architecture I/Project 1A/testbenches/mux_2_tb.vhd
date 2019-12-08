-- Test bench for 2-to-1 Multiplexer

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_tb is end mux2_tb;

architecture behave of mux2_tb is

	signal in0_sig: std_logic_vector (3 downto 0) := "0000";
	signal in1_sig: std_logic_vector (3 downto 0) := "0000";
	signal s_sig: std_logic := '0';
	signal z_sig: std_logic_vector (3 downto 0);

	component mux2 is
		port(
			in0, in1: in std_logic_vector (3 downto 0);
			s: in std_logic;
			z: out std_logic_vector (3 downto 0)
		);
	end component mux2;

begin

	mux_inst: mux2
	port map(
		in0 => in0_sig,
		in1 => in1_sig,
		s => s_sig,
		z => z_sig
	);

	process is
	begin
		in0_sig <= "0001";
		in1_sig <= "0010";
		wait for 10ns;
		s_sig <= '0';
		wait for 100ns;
		s_sig <= '1';
		wait for 100ns;
	end process;

end behave;
