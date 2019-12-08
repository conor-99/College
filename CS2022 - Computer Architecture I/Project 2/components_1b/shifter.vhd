-- Shifter
-- Taken from Project1B

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter is
	port(
		H: in std_logic_vector (1 downto 0);
		data_B: in std_logic_vector (15 downto 0);
		data_O: out std_logic_vector (15 downto 0)
	);
end shifter;

architecture behave of shifter is
constant delay: Time := 1ns;
begin
	data_O <=
		data_B after delay when H = "00" else
		('0' & data_B (15 downto 1)) after delay when H = "01" else
		(data_B (14 downto 0) & '0') after delay when H = "10" else
		data_B after delay
	;
end behave;
