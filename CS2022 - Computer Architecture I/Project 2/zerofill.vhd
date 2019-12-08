-- Zerofill

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zerofill is
	port(
		SB_I: in std_logic_vector (2 downto 0);
		SB_O: out std_logic_vector (15 downto 0)
	);
end zerofill;

architecture behave of zerofill is
constant delay: Time := 1ns;
begin
	SB_O (2 downto 0) <= SB_I;
	SB_O (15 downto 3) <= "0000000000000";
end behave;
