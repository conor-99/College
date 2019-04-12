-- Register (4-bit)
-- Taken from Project1A

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
	port(
		D: in std_logic_vector (3 downto 0);
		load, Clk: in std_logic;
		Q: out std_logic_vector (3 downto 0)
	);
end reg;

architecture behave of reg is
constant delay: Time := 5ns;
begin
	process(Clk)
	begin
		if (rising_edge(Clk)) then
			if load = '1' then
				Q <= D after delay;
			end if;
		end if;
	end process;
end behave;
