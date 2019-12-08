-- 16-to-1 Multiplexer

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux16 is
	port(
		in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15: in std_logic_vector (15 downto 0);
		s0, s1, s2, s3: in std_logic;
		z: out std_logic_vector (15 downto 0)
	);
end mux16;

architecture behave of mux16 is
constant delay: Time := 5ns;
begin
	z <= 
		in0 after delay when s0 = '0' and s1 = '0' and s2 = '0' and s3 = '0' else
		in1 after delay when s0 = '0' and s1 = '0' and s2 = '0' and s3 = '1' else
		in2 after delay when s0 = '0' and s1 = '0' and s2 = '1' and s3 = '0' else
		in3 after delay when s0 = '0' and s1 = '0' and s2 = '1' and s3 = '1' else
		in4 after delay when s0 = '0' and s1 = '1' and s2 = '0' and s3 = '0' else
		in5 after delay when s0 = '0' and s1 = '1' and s2 = '0' and s3 = '1' else
		in6 after delay when s0 = '0' and s1 = '1' and s2 = '1' and s3 = '0' else
		in7 after delay when s0 = '0' and s1 = '1' and s2 = '1' and s3 = '1' else
		in8 after delay when s0 = '1' and s1 = '0' and s2 = '0' and s3 = '0' else
		in9 after delay when s0 = '1' and s1 = '0' and s2 = '0' and s3 = '1' else
		in10 after delay when s0 = '1' and s1 = '0' and s2 = '1' and s3 = '0' else
		in11 after delay when s0 = '1' and s1 = '0' and s2 = '1' and s3 = '1' else
		in12 after delay when s0 = '1' and s1 = '1' and s2 = '0' and s3 = '0' else
		in13 after delay when s0 = '1' and s1 = '1' and s2 = '0' and s3 = '1' else
		in14 after delay when s0 = '1' and s1 = '1' and s2 = '1' and s3 = '0' else
		in15 after delay when s0 = '1' and s1 = '1' and s2 = '1' and s3 = '1' else
		"0000000000000000" after delay
	;
end behave;
