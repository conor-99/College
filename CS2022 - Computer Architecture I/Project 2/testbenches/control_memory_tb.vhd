-- Test bench for Control Memory

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_memory_tb is end control_memory_tb;

architecture behave of control_memory_tb is

	signal car_I_sig: std_logic_vector (7 downto 0) := x"00";
	signal MC_sig, IL_sig, PI_sig, PL_sig, TD_sig, TA_sig: std_logic;
	signal TB_sig, MB_sig, MD_sig, RW_sig, MM_sig, MW_sig: std_logic;
	signal MS_sig: std_logic_vector (2 downto 0);
	signal FS_sig: std_logic_vector (4 downto 0);
	signal NA_sig: std_logic_vector (7 downto 0);

	component control_memory is
		port (
			car_I: in std_logic_vector (7 downto 0);
			MC, IL, PI, PL, TD, TA: out std_logic;
			TB, MB, MD, RW, MM, MW: out std_logic;
			MS: out std_logic_vector (2 downto 0);
			FS: out std_logic_vector (4 downto 0);
			NA: out std_logic_vector (7 downto 0)
		);
	end component control_memory;

begin

	control_memory_inst: control_memory
	port map(
		car_I => car_I_sig,
		MC => MC_sig,
		IL => IL_sig,
		PI => PI_sig,
		PL => PL_sig,
		TD => TD_sig,
		TA => TA_sig,
		TB => TB_sig,
		MB => MB_sig,
		MD => MD_sig,
		RW => RW_sig,
		MM => MM_sig,
		MW => MW_sig,
		MS => MS_sig,
		FS => FS_sig,
		NA => NA_sig
	);

	process is
	begin
		car_I_sig <= x"02";
		wait for 100ns;
		car_I_sig <= x"01";
		wait for 100ns;
	end process;

end behave;
