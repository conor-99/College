-- Test bench for Register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_tb is end reg_tb;

architecture behave of reg_tb is

	signal D_sig: std_logic_vector (3 downto 0) := "0000";
	signal load_sig: std_logic := '0';
	signal Clk_sig: std_logic := '0';
	signal Q_sig: std_logic_vector (3 downto 0);

	component reg is
		port(
			D: in std_logic_vector (3 downto 0);
			load, Clk: in std_logic;
			Q: out std_logic_vector (3 downto 0)
		);
	end component reg;

begin

	reg_inst: reg
	port map(
		D => D_sig,
		load => load_sig,
		Clk => Clk_sig,
		Q => Q_sig
	);

	process is
	begin
		D_sig <= "0101";
		load_sig <= '1';
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		D_sig <= "1010";
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		wait for 100ns;
		load_sig <= '0';
	end process;

end behave;
