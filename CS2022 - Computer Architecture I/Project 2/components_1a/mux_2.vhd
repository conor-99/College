-- 2-to-1 Multiplexer (4-bit)
-- Taken from Project1A

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
	port(
		in0, in1: in std_logic_vector (3 downto 0);
		s: in std_logic;
		z: out std_logic_vector (3 downto 0)
	);
end mux2;

architecture behave of mux2 is
constant delay: Time := 5ns;
begin
	z <= 
		in0 after delay when s = '0' else
		in1 after delay when s = '1' else
		"0000" after delay
	;
end behave;
