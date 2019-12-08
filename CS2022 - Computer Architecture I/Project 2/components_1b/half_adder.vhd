-- Half Adder
-- Taken from Project1B

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
	port(
		a, b: in std_logic;
		s, c: out std_logic
	);
end half_adder;

architecture behave of half_adder is
begin
	s <= a xor b;
	c <= a and b;
end behave;
