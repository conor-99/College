-- Test bench for Control Address Register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity car_tb is end car_tb;

architecture behave of car_tb is

	signal car_I_sig: std_logic_vector (7 downto 0) := x"00";
	signal Clk_sig: std_logic := '0';
	signal reset_sig: std_logic := '0';
	signal load_sig: std_logic := '0';
	signal car_O_sig: std_logic_vector (7 downto 0);
	
	component car is
		port (
			car_I: in std_logic_vector (7 downto 0);
			Clk, reset, load: in std_logic;
			car_O: out std_logic_vector (7 downto 0)
		);
	end component car;

begin

	car_inst: car
	port map(
		car_I => car_I_sig,
		Clk => Clk_sig,
		reset => reset_sig,
		load => load_sig,
		car_O => car_O_sig
	);

	process is
	begin
		car_I_sig <= x"AA";
		Clk_sig <= '0';
		reset_sig <= '0';
		load_sig <= '1';
		wait for 100ns;
	end process;

end behave;
