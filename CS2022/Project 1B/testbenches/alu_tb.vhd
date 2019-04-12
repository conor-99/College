-- Test bench for ALU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_tb is end alu_tb;

architecture behave of alu_tb is

	signal G_sig: std_logic_vector (3 downto 0) := "0000";
	signal data_A_sig, data_B_sig: std_logic_vector (15 downto 0);
	signal V_sig, C_sig: std_logic;
	signal data_O_sig: std_logic_vector (15 downto 0);
	
	component alu is
		port (
			G: in std_logic_vector (3 downto 0);
			data_A, data_B: in std_logic_vector (15 downto 0);
			V, C: out std_logic;
			data_O: out std_logic_vector (15 downto 0)
		);
	end component alu;

begin

	alu_inst: alu
	port map(
		G => G_sig,
		data_A => data_A_sig,
		data_B => data_B_sig,
		V => V_sig,
		C => C_sig,
		data_O => data_O_sig
	);

	process is
	begin
		
		G_sig <= "0001";
		data_A_sig <= "0000000000000010";
		data_B_sig <= "0000000000000000";
		
	end process;

end behave;
