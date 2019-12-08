-- Zero Detector
-- Taken from Project1B

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zerodet is
	port(
		data: in std_logic_vector (15 downto 0);
		Z: out std_logic
	);
end zerodet;

architecture behave of zerodet is
constant delay: Time := 1ns;
begin
	Z <=
		'1' after delay when data = x"0000" else
		'0' after delay
	;
end behave;

