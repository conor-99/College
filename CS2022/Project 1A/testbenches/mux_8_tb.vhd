-- Test bench for 8-to-1 Multiplexer

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8_tb is end mux8_tb;

architecture behave of mux8_tb is

	signal in0_sig: std_logic_vector (3 downto 0) := "0000";
	signal in1_sig: std_logic_vector (3 downto 0) := "0000";
	signal in2_sig: std_logic_vector (3 downto 0) := "0000";
	signal in3_sig: std_logic_vector (3 downto 0) := "0000";
	signal in4_sig: std_logic_vector (3 downto 0) := "0000";
	signal in5_sig: std_logic_vector (3 downto 0) := "0000";
	signal in6_sig: std_logic_vector (3 downto 0) := "0000";
	signal in7_sig: std_logic_vector (3 downto 0) := "0000";
	signal s0_sig: std_logic := '0';
	signal s1_sig: std_logic := '0';
	signal s2_sig: std_logic := '0';
	signal z_sig: std_logic_vector (3 downto 0);

	component mux8 is
		port(
			in0, in1, in2, in3, in4, in5, in6, in7: in std_logic_vector (3 downto 0);
			s0, s1, s2: in std_logic;
			z: out std_logic_vector (3 downto 0)
		);
	end component mux8;

begin

	mux_inst: mux8
	port map(
		in0 => in0_sig,
		in1 => in1_sig,
		in2 => in2_sig,
		in3 => in3_sig,
		in4 => in4_sig,
		in5 => in5_sig,
		in6 => in6_sig,
		in7 => in7_sig,
		s0 => s0_sig,
		s1 => s1_sig,
		s2 => s2_sig,
		z => z_sig
	);

	process is
	begin
		in0_sig <= "0000";
		in1_sig <= "0001";
		in2_sig <= "0010";
		in3_sig <= "0011";
		in4_sig <= "0100";
		in5_sig <= "0101";
		in6_sig <= "0110";
		in7_sig <= "0111";	
		wait for 10ns;
		s0_sig <= '0';
		s1_sig <= '1';
		s2_sig <= '0';
		wait for 100ns;
		s0_sig <= '1';
		s1_sig <= '1';
		s2_sig <= '0';
		wait for 100ns;
		s0_sig <= '1';
		s1_sig <= '0';
		s2_sig <= '0';
		wait for 100ns;
	end process;

end behave;
