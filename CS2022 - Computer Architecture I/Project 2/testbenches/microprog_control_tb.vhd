-- Test bench for Microprogrammed Control

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microprog_control_tb is end microprog_control_tb;

architecture behave of microprog_control_tb is

	signal V_sig: std_logic := '0';
	signal C_sig: std_logic := '0';
	signal N_sig: std_logic := '0';
	signal Z_sig: std_logic := '0';
	signal Clk_sig: std_logic := '0';
	signal reset_sig: std_logic := '0';
	signal data_I_sig: std_logic_vector (15 downto 0);
	signal TD_sig, TA_sig, TB_sig, MB_sig, MD_sig, RW_sig, MM_sig, MW_sig: std_logic;
	signal DR_sig, SA_sig, SB_sig: std_logic_vector (2 downto 0);
	signal FS_sig: std_logic_vector (4 downto 0);
	signal PC_O_sig: std_logic_vector (15 downto 0);
	signal zfill_O_sig: std_logic_vector (15 downto 0);
	
	component microprog_control is
		port (
			V, C, N, Z, Clk, reset: in std_logic;
			data_I: in std_logic_vector (15 downto 0);
			TD, TA, TB, MB, MD, RW, MM, MW: out std_logic;
			DR, SA, SB: out std_logic_vector (2 downto 0);
			FS: out std_logic_vector (4 downto 0);
			PC_O: out std_logic_vector (15 downto 0);
			zfill_O: out std_logic_vector (15 downto 0)
		);
	end component microprog_control;

begin

	microprog_control_inst: microprog_control
	port map(
		V => V_sig,
		C => C_sig,
		N => N_sig,
		Z => Z_sig,
		Clk => Clk_sig,
		reset => reset_sig,
		data_I => data_I_sig,
		TD => TD_sig,
		TA => TA_sig,
		TB => TB_sig,
		MB => MB_sig,
		MD => MD_sig,
		RW => RW_sig,
		MM => MM_sig,
		MW => MW_sig,
		DR => DR_sig,
		SA => SA_sig,
		SB => SB_sig,
		FS => FS_sig,
		PC_O => PC_O_sig,
		zfill_O => zfill_O_sig
	);

	process is
	begin
		data_I_sig <= x"0000";
		reset_sig <= '0';
		Clk_sig <= '0';
		wait for 100ns;
		data_I_sig <= x"0048"; -- 0000000001001000
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
	end process;

end behave;
