-- Extend

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity extend is
	port(
		DR, SB: in std_logic_vector (2 downto 0);
		ext_O: out std_logic_vector (15 downto 0)
	);
end extend;

architecture behave of extend is
	constant delay: Time := 5ns;
begin
	ext_O(2 downto 0) <= SB after delay;
	ext_O(5 downto 3) <= DR after delay;
	ext_O(15 downto 6) <= "0000000000" when DR(2) = '0' else "1111111111" after delay;
end behave;
