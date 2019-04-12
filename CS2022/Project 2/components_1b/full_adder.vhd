-- Full Adder
-- Taken from Project1B

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
	port(
		a, b, ci: in std_logic;
		s, co: out std_logic
	);
end full_adder;

architecture behave of full_adder is
	
	component half_adder
	port(
		a, b: in std_logic;
		s, c: out std_logic
	);
	end component;

	signal s1, s2, s3: std_logic;

begin
	
	half_adder_1: half_adder port map (a, b, s1, s2);
	half_adder_2: half_adder port map (ci, s1, s, s3);
	
	co <= s2 or s3;

end behave;
