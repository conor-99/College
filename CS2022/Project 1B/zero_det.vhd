-- Zero Detector

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zerodet is
	port(
		-- Clock
		Clk: in std_logic;
		-- Data
		data: in std_logic_vector (3 downto 0);
		-- Flag
		Z: out std_logic
	);
end zerodet;

architecture behave of zerodet is
constant delay: Time := 1ns;
begin
	process(Clk)
	begin
		if (rising_edge(Clk)) then
			if data = "0000" then 	Z <= '1';
			else 			Z <= '0';
			end if;
		end if;
	end process;
end behave;

