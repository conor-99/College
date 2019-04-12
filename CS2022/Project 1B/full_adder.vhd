-- Full Adder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladder is
	port(
		a, b, ci: in std_logic;
		s, co: out std_logic
	);
end fulladder;

architecture dataflow of fulladder is
	signal s1, s2, s3: std_logic;
	constant delay: Time := 1ns;
begin
	s1 <= (a xor b) after delay;
	s2 <= (ci and s1) after delay;
	s3 <= (a and b) after delay;
	s <= (s1 xor ci) after delay;
	co <= (s2 or s3) after delay;
end dataflow;
