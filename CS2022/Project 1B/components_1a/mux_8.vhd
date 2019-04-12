-- 8-to-1 Multiplexer (4-bit)
-- Taken from Project1A

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8 is
	port(
		in0, in1, in2, in3, in4, in5, in6, in7: in std_logic_vector (3 downto 0);
		s0, s1, s2: in std_logic;
		z: out std_logic_vector (3 downto 0)
	);
end mux8;

architecture behave of mux8 is
constant delay: Time := 5ns;
begin
	z <= 
		in0 after delay when s0 = '0' and s1 = '0' and s2 = '0' else
		in1 after delay when s0 = '0' and s1 = '0' and s2 = '1' else
		in2 after delay when s0 = '0' and s1 = '1' and s2 = '0' else
		in3 after delay when s0 = '0' and s1 = '1' and s2 = '1' else
		in4 after delay when s0 = '1' and s1 = '0' and s2 = '0' else
		in5 after delay when s0 = '1' and s1 = '0' and s2 = '1' else
		in6 after delay when s0 = '1' and s1 = '1' and s2 = '0' else
		in7 after delay when s0 = '1' and s1 = '1' and s2 = '1' else
		"0000" after delay
	;
end behave;
