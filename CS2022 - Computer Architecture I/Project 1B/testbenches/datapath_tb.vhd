-- Test bench for Datapath

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_tb is end datapath_tb;

architecture behave of datapath_tb is

	signal data_I_sig, const_I_sig: std_logic_vector (15 downto 0);
	signal F_sig: std_logic_vector (4 downto 0) := "00000";
	signal dst_A_sig, src_A_sig, src_B_sig: std_logic_vector (2 downto 0);
	signal MB_sig, MD_sig, Clk_sig: std_logic;
	signal data_O_sig, addr_O_sig: std_logic_vector (15 downto 0);
	signal V_sig, C_sig, N_sig, Z_sig: std_logic;
	
	component datapath is
		port(
			data_I, const_I: in std_logic_vector (15 downto 0);
			F: in std_logic_vector (4 downto 0);
			dst_A, src_A, src_B: in std_logic_vector (2 downto 0);
			MB, MD, Clk: in std_logic;
			data_O, addr_O: out std_logic_vector (15 downto 0);
			V, C, N, Z: out std_logic
		);
	end component datapath;
	
begin

	datapath_inst: datapath
	port map(
		data_I => data_I_sig,
		const_I => const_I_sig,
		F => F_sig,
		dst_A => dst_A_sig,
		src_A => src_A_sig,
		src_B => src_B_sig,
		MB => MB_sig,
		MD => MD_sig,
		Clk => Clk_sig,
		data_O => data_O_sig,
		addr_O => addr_O_sig,
		V => V_sig,
		C => C_sig,
		N => N_sig,
		Z => Z_sig
	);

	process is
	begin
		
		dst_A_sig <= "001";
		src_A_sig <= "010";
		src_B_sig <= "011";
		data_I_sig <= x"0101";
		const_I_sig <= x"0000";
		F_sig <= "00000";
		MB_sig <= '0';
		MD_sig <= '1';
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		wait for 100ns;
		src_A_sig <= "001";
		F_sig <= "00110";
		MD_sig <= '0';
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
		
	end process;

end behave;
