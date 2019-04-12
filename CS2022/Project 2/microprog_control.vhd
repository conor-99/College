-- Microprogrammed Control

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity microprog_control is
	port(
		i: in std_logic
	);
end microprog_control;

architecture behave of microprog_control is
	constant delay: Time := 5ns;
begin
	
end behave;
