-- Test bench for Function Unit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity func_unit_tb is end func_unit_tb;

architecture behave of func_unit_tb is

	signal F_sig: std_logic_vector (4 downto 0) := "00000";
	signal data_A_sig, data_B_sig: std_logic_vector (15 downto 0);
	signal V_sig, C_sig, N_sig, Z_sig: std_logic;
	signal data_O_sig: std_logic_vector (15 downto 0);
	
	component func_unit is
		port (
			F: in std_logic_vector (4 downto 0);
			data_A, data_B: in std_logic_vector (15 downto 0);
			V, C, N, Z: out std_logic;
			data_O: out std_logic_vector (15 downto 0)
		);
	end component func_unit;

begin

	func_unit_inst: func_unit
	port map(
		F => F_sig,
		data_A => data_A_sig,
		data_B => data_B_sig,
		V => V_sig,
		C => C_sig,
		N => N_sig,
		Z => Z_sig,
		data_O => data_O_sig
	);

	process is
	begin		
		F_sig <= "00001";
		data_A_sig <= "0000000000000000";
		data_B_sig <= "0000000000000000";
		wait for 100ns;
		F_sig <= "00010";
		data_A_sig <= "0000000000000010";
		data_B_sig <= "0000000000000001";
		wait for 100ns;
		F_sig <= "01000";
		data_A_sig <= "0000000000000011";
		data_B_sig <= "0000000000000001";
		wait for 100ns;
		F_sig <= "10100";
		data_A_sig <= "0000000000000000";
		data_B_sig <= "0000000000000010";
		wait for 100ns;		
	end process;

end behave;
