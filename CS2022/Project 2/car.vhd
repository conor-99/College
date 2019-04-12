-- Control Address Register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity car is
	port(
		car_I: in std_logic_vector (7 downto 0);
		Clk, reset, load: in std_logic;
		car_O: out std_logic_vector (7 downto 0)
	);
end car;

architecture behave of car is
	constant delay: Time := 5ns;
begin
	process(Clk)
	begin
		if reset = '1' then car_O <= "00000000";
		else
			if rising_edge(Clk) then
				if load = '1' then car_O <= car_I;
				else car_O <= car_I + 1;
				end if;
			end if;
		end if;
	end process;
end behave;
