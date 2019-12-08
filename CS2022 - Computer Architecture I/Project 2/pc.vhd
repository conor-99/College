-- Program Counter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
	port(
		data_I: in std_logic_vector (15 downto 0);
		PL, PI, reset: in std_logic;
		data_O: out std_logic_vector (15 downto 0)
	);
end pc;

architecture behave of pc is
	constant delay: Time := 5ns;
begin
	process (PL, PI, reset)
		variable stored: std_logic_vector (15 downto 0); -- store that value 'in memory'
	begin
		if reset = '1' then stored := x"0000";
		elsif PL = '1' then stored := stored + data_I;
		elsif PI = '1' then stored := stored + x"0001";
		end if;
		data_O <= stored after delay;
	end process;
end behave;
