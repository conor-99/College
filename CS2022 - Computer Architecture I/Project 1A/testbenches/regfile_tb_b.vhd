-- Test bench for Register File

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regfile_tb_b is end regfile_tb_b;

architecture behave of regfile_tb_b is

	signal src_s0_sig: std_logic := '0';
	signal src_s1_sig: std_logic := '0';
	signal src_s2_sig: std_logic := '0';
	signal des_A0_sig: std_logic := '0';
	signal des_A1_sig: std_logic := '0';
	signal des_A2_sig: std_logic := '0';
	signal Clk_sig: std_logic := '0';
	signal data_src_sig: std_logic := '0';
	signal data_sig: std_logic_vector (3 downto 0) := "0000";
	signal reg0_sig: std_logic_vector (3 downto 0) := "0000";
	signal reg1_sig: std_logic_vector (3 downto 0) := "0000";
	signal reg2_sig: std_logic_vector (3 downto 0) := "0000";
	signal reg3_sig: std_logic_vector (3 downto 0) := "0000";
	signal reg4_sig: std_logic_vector (3 downto 0) := "0000";
	signal reg5_sig: std_logic_vector (3 downto 0) := "0000";
	signal reg6_sig: std_logic_vector (3 downto 0) := "0000";
	signal reg7_sig: std_logic_vector (3 downto 0) := "0000";
	
	component regfile is
		port(
			src_s0, src_s1, src_s2: in std_logic;
			des_A0, des_A1, des_A2: in std_logic;
			Clk: in std_logic;
			data_src: in std_logic;
			data: in std_logic_vector (3 downto 0);
			reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7: out std_logic_vector (3 downto 0)
		);
	end component regfile;

begin

	regfile_inst: regfile
	port map(
		src_s0 => src_s0_sig,
		src_s1 => src_s1_sig,
		src_s2 => src_s2_sig,
		des_A0 => des_A0_sig,
		des_A1 => des_A1_sig,
		des_A2 => des_A2_sig,
		Clk => Clk_sig,
		data_src => data_src_sig,
		data => data_sig,
		reg0 => reg0_sig,
		reg1 => reg1_sig,
		reg2 => reg2_sig,
		reg3 => reg3_sig,
		reg4 => reg4_sig,
		reg5 => reg5_sig,
		reg6 => reg6_sig,
		reg7 => reg7_sig
	);

	process is
	begin
		-- initialisation
		src_s0_sig <= '0';
		src_s1_sig <= '0';
		src_s2_sig <= '0';
		data_src_sig <= '0';
		-- reg0
		des_A0_sig <= '0';
		des_A1_sig <= '0';
		des_A2_sig <= '0';
		data_sig <= "0000";
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		-- reg1
		des_A0_sig <= '0';
		des_A1_sig <= '0';
		des_A2_sig <= '1';
		data_sig <= "0001";
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		-- move reg1 to reg0
		src_s0_sig <= '0';
		src_s1_sig <= '0';
		src_s2_sig <= '1';
		des_A0_sig <= '0';
		des_A1_sig <= '0';
		des_A2_sig <= '0';
		data_src_sig <= '1';		
		Clk_sig <= '0';
		wait for 100ns;
		Clk_sig <= '1';
		wait for 100ns;
		Clk_sig <= '0';
	end process;

end behave;
