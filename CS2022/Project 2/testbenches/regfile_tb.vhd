-- Test bench for Register File

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regfile_tb is end regfile_tb;

architecture behave of regfile_tb is

	signal src_A0_sig: std_logic := '0';
	signal src_A1_sig: std_logic := '0';
	signal src_A2_sig: std_logic := '0';
	signal src_A3_sig: std_logic := '0';
	signal src_B0_sig: std_logic := '0';
	signal src_B1_sig: std_logic := '0';
	signal src_B2_sig: std_logic := '0';
	signal src_B3_sig: std_logic := '0';
	signal des_A0_sig: std_logic := '0';
	signal des_A1_sig: std_logic := '0';
	signal des_A2_sig: std_logic := '0';
	signal des_A3_sig: std_logic := '0';
	signal Clk_sig: std_logic := '0';
	signal RW_sig: std_logic := '0';
	signal data_sig: std_logic_vector (15 downto 0) := x"0000";
	signal data_A_sig: std_logic_vector (15 downto 0);
	signal data_B_sig: std_logic_vector (15 downto 0);

	component regfile is
		port(
			src_A0, src_A1, src_A2, src_A3: in std_logic;
			src_B0, src_B1, src_B2, src_B3: in std_logic;
			des_A0, des_A1, des_A2, des_A3: in std_logic;
			Clk, RW: in std_logic;
			data: in std_logic_vector (15 downto 0);
			data_A, data_B: out std_logic_vector (15 downto 0)
		);
	end component regfile;
	
begin

	regfile_inst: regfile
	port map(
		src_A0 => src_A0_sig,
		src_A1 => src_A1_sig,
		src_A2 => src_A2_sig,
		src_A3 => src_A3_sig,
		src_B0 => src_B0_sig,
		src_B1 => src_B1_sig,
		src_B2 => src_B2_sig,
		src_B3 => src_B3_sig,
		des_A0 => des_A0_sig,
		des_A1 => des_A1_sig,
		des_A2 => des_A2_sig,
		des_A3 => des_A3_sig,
		Clk => Clk_sig,
		RW => RW_sig,
		data => data_sig,
		data_A => data_A_sig,
		data_B => data_B_sig
	);

	process is
	begin
		RW_sig <= '1';
		des_A0_sig <= '0';
		des_A1_sig <= '0';
		des_A2_sig <= '0';
		des_A3_sig <= '1';
		src_A0_sig <= '0';
		src_A1_sig <= '0';
		src_A2_sig <= '0';
		src_A3_sig <= '1';
		data_sig <= x"DEAD";
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		des_A0_sig <= '0';
		des_A1_sig <= '0';
		des_A2_sig <= '1';
		des_A3_sig <= '0';
		src_B0_sig <= '0';
		src_B1_sig <= '0';
		src_B2_sig <= '1';
		src_B3_sig <= '0';
		data_sig <= x"BEEF";
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
	end process;

end behave;
