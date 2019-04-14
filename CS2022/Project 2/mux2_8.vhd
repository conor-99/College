-- 2-to-1 Multiplexer (8-bit)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_8 is
	port(
		in0, in1: in std_logic_vector (7 downto 0);
		s: in std_logic;
		z: out std_logic_vector (7 downto 0)
	);
end mux2_8;

architecture behave of mux2_8 is
constant delay: Time := 5ns;
begin
	z <= 
		in0 after delay when s = '0' else
		in1 after delay when s = '1' else
		"00000000" after delay
	;
end behave;
