-- Test bench for 3-to-8 Decoder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec8_tb is end dec8_tb;

architecture behave of dec8_tb is

	signal A0_sig: std_logic := '0';
	signal A1_sig: std_logic := '0';
	signal A2_sig: std_logic := '0';
	signal Q0_sig: std_logic := '0';
	signal Q1_sig: std_logic := '0';
	signal Q2_sig: std_logic := '0';
	signal Q3_sig: std_logic := '0';
	signal Q4_sig: std_logic := '0';
	signal Q5_sig: std_logic := '0';
	signal Q6_sig: std_logic := '0';
	signal Q7_sig: std_logic := '0';

	component dec8 is
		port(
			A0, A1, A2: in std_logic;
			Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7: out std_logic
		);
	end component dec8;

begin

	dec_inst: dec8
	port map(
		A0 => A0_sig,
		A1 => A1_sig,
		A2 => A2_sig,
		Q0 => Q0_sig,
		Q1 => Q1_sig,
		Q2 => Q2_sig,
		Q3 => Q3_sig,
		Q4 => Q4_sig,
		Q5 => Q5_sig,
		Q6 => Q6_sig,
		Q7 => Q7_sig
	);

	process is
	begin
		A0_sig <= '0';
		A1_sig <= '0';
		A2_sig <= '0';
		wait for 100ns;
		A0_sig <= '1';
		wait for 100ns;
		A1_sig <= '1';
		wait for 100ns;
		A2_sig <= '1';
		wait for 100ns;
	end process;

end behave;
