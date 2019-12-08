-- Datapath (TLS)
-- Modified version of the one from Project 1B

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath is
	port(
		data_I, const_I, PC_I: in std_logic_vector (15 downto 0);
		F: in std_logic_vector (4 downto 0);
		dst_A, src_A, src_B: in std_logic_vector (3 downto 0);
		RW, MB, MD, MM, Clk: in std_logic;
		data_O, addr_O: out std_logic_vector (15 downto 0);
		V, C, N, Z: out std_logic
	);
end datapath;

architecture behave of datapath is
	
	component func_unit
		port(
			F: in std_logic_vector (4 downto 0);
			data_A, data_B: in std_logic_vector (15 downto 0);
			V, C, N, Z: out std_logic;
			data_O: out std_logic_vector (15 downto 0)
		);
	end component;

	component regfile
		port(
			src_A0, src_A1, src_A2, src_A3: in std_logic;
			src_B0, src_B1, src_B2, src_B3: in std_logic;
			des_A0, des_A1, des_A2, des_A3: in std_logic;
			Clk, RW: in std_logic;
			data: in std_logic_vector (15 downto 0);
			data_A, data_B: out std_logic_vector (15 downto 0)
		);
	end component;

	component mux2
		port(
			in0, in1: in std_logic_vector (15 downto 0);
			s: in std_logic;
			z: out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal muxb_O: std_logic_vector (15 downto 0);
	signal reg_B: std_logic_vector (15 downto 0);
	signal reg_A: std_logic_vector (15 downto 0);
	signal muxd_O: std_logic_vector (15 downto 0);
	signal func_O: std_logic_vector (15 downto 0);
	signal muxm_O: std_logic_vector (15 downto 0);
	
begin
	
	comp_func: func_unit port map (F, reg_A, muxb_O, V, C, N, Z, func_O);
	
	comp_regs: regfile port map (
		src_A(0), src_A(1), src_A(2), src_A(3),
		src_B(0), src_B(1), src_B(2), src_B(3),
		dst_A(0), dst_A(1), dst_A(2), dst_A(3),
		Clk, RW, muxd_O, reg_A, reg_B
	);
	
	comp_muxb: mux2 port map (reg_B, const_I, MB, muxb_O);
	comp_muxd: mux2 port map (func_O, data_I, MD, muxd_O);
	comp_muxm: mux2 port map (reg_A, PC_I, MM, muxm_O);
	
	data_O <= muxb_O; 
	addr_O <= muxm_O;
	
end behave;
