-- Shifter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter is
	port(
		-- H select
		H: in std_logic_vector (1 downto 0);
		-- Clock
		Clk: in std_logic;
		-- B data
		data_B: in std_logic_vector (3 downto 0);
		-- Output data
		data_O: out std_logic_vector (3 downto 0)
	);
end shifter;

architecture behave of shifter is
constant delay: Time := 1ns;
begin
	process(Clk)
	begin
		if (rising_edge(Clk)) then

			case H is
				-- O = B
				when "00" => data_O <= data_B;
				-- O = B >> 1
				when "01" => data_O <= '0' & data_B (3 downto 1);
				-- O = B << 1
				when "10" => data_O <= data_B (2 downto 0) & '0';
				-- O = B
				when others => data_O <= data_B;
			end case;

		end if;
	end process;
end behave;
