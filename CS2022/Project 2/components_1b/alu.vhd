-- ALU
-- Taken from Project1B

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
	port(
		G: in std_logic_vector (3 downto 0);
		data_A, data_B: in std_logic_vector (15 downto 0);
		V, C: out std_logic;
		data_O: out std_logic_vector (15 downto 0)
	);
end alu;

architecture behave of alu is
	
	component ripple_adder_16
		port(
			B, A: in std_logic_vector (15 downto 0);
			CI: in std_logic;
			S: out std_logic_vector (15 downto 0);
			CO, V: out std_logic
		);
	end component;
	
	signal ra_a, ra_b, ra_s: std_logic_vector (15 downto 0);
	signal ra_ci, ra_co, ra_v: std_logic;
	
	constant delay: Time := 1ns;
	
begin

	fa: ripple_adder_16 port map (ra_a, ra_b, ra_ci, ra_s, ra_co, ra_v);

	ra_a <=
		(data_A and data_B) after delay when G = "1000" else
		(data_A or data_B) after delay when G = "1010" else
		(data_A xor data_B) after delay when G = "1100" else
		(not data_A) after delay when G = "1110" else
		data_A after delay
	;

	ra_b <=
		data_B after delay when (G = "0010" or G = "0011") else
		(not data_B) after delay when (G = "0100" or G = "0101") else
		x"0001" after delay when G = "0001" else
		x"FFFF" after delay when G = "0110" else
		x"0000" after delay
	;

	ra_ci <=
		'1' after delay when (G = "0011" or G = "0101") else
		'0' after delay
	;

	V <= ra_v;
	C <= ra_co;
	data_O <= ra_s;

end behave;
