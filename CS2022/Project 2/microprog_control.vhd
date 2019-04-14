-- Microprogrammed Control

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity microprog_control is
	port(
		V, C, N, Z, Clk, reset: in std_logic;
		data_I: in std_logic_vector (15 downto 0);
		TD, TA, TB, MB, MD, RW, MM, MW: out std_logic;
		DR, SA, SB: out std_logic_vector (2 downto 0);
		FS: out std_logic_vector (4 downto 0);
		PC_O: out std_logic_vector (15 downto 0);
		zfill_O: out std_logic_vector (15 downto 0)
	);
end microprog_control;

architecture behave of microprog_control is
	
	component extend
		port(
			DR, SB: in std_logic_vector (2 downto 0);
			ext_O: out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal ext_DR, ext_SB: std_logic_vector (2 downto 0);
	signal ext_O: std_logic_vector (15 downto 0);

	component pc
		port(
			data_I: in std_logic_vector (15 downto 0);
			PL, PI, reset: in std_logic;
			data_O: out std_logic_vector (15 downto 0)
		);
	end component;

	signal PC_PL, PC_PI: std_logic;
	
	component inst_reg
		port(
			ins_I: in std_logic_vector (15 downto 0);
			IL: in std_logic;
			DR, SA, SB: out std_logic_vector (2 downto 0);
			op_O: out std_logic_vector (7 downto 0)
		);
	end component;
	
	signal IR_OP: std_logic_vector (7 downto 0);
	signal IR_IL: std_logic;
	signal IR_DR, IR_SA, IR_SB: std_logic_vector (2 downto 0);
	
	component car
		port(
			car_I: in std_logic_vector (7 downto 0);
			Clk, reset, load: std_logic;
			car_O: out std_logic_vector (7 downto 0)
		);
	end component;
	
	signal car_I: std_logic_vector (7 downto 0);
	signal car_load: std_logic;
	signal car_O: std_logic_vector (7 downto 0);
	
	component control_memory
		port(
			car_I: in std_logic_vector (7 downto 0);
			MC, IL, PI, PL, TD, TA: out std_logic;
			TB, MB, MD, RW, MM, MW: out std_logic;
			MS: out std_logic_vector (2 downto 0);
			FS: out std_logic_vector (4 downto 0);
			NA: out std_logic_vector (7 downto 0)
		);
	end component;
	
	signal cm_I: std_logic_vector (7 downto 0);
	signal cm_NA: std_logic_vector (7 downto 0);
	signal cm_FS: std_logic_vector (4 downto 0);
	signal cm_MS: std_logic_vector (2 downto 0);
	signal cm_MC, cm_IL, cm_PI, cm_PL, cm_TD, cm_TA: std_logic;
	signal cm_TB, cm_MB, cm_MD, cm_RW, cm_MM, cm_MW: std_logic;
	
	component zerofill
		port(
			SB_I: in std_logic_vector (2 downto 0);
			SB_O: out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal zf_I: std_logic_vector (2 downto 0);
	signal zf_O: std_logic_vector (15 downto 0);
	
	component mux8_1
		port(
			in0, in1, in2, in3, in4, in5, in6, in7: in std_logic;
			s0, s1, s2: in std_logic;
			z: out std_logic
		);
	end component;
	
	signal m8_MS: std_logic_vector (2 downto 0);
	signal m8_O, const_0, const_1, not_C, not_Z: std_logic;
	
	component mux2_8
		port(
			in0, in1: in std_logic_vector (7 downto 0);
			s: in std_logic;
			z: out std_logic_vector (7 downto 0)
		);
	end component;
	
	signal m2_NA, m2_OP: std_logic_vector (7 downto 0);
	signal m2_MC: std_logic;
	signal m2_O: std_logic_vector (7 downto 0);
	
begin
	
	ext_DR <= IR_DR;
	ext_SB <= IR_SB;
	comp_ext: extend port map (
		ext_DR, ext_SB, ext_O
	);
	
	PC_PL <= cm_PL;
	PC_PI <= cm_PI;
	comp_pc: pc port map (
		ext_O, PC_PL, PC_PI, reset, PC_O
	);
	
	IR_IL <= cm_IL;
	comp_ireg: inst_reg port map (
		data_I, IR_IL, IR_DR, IR_SA, IR_SB, IR_OP
	);
	
	car_I <= m2_O;
	comp_car: car port map (
		car_I, Clk, reset, car_load, car_O
	);
	
	cm_I <= car_O;
	comp_cmem: control_memory port map (
		cm_I,
		cm_MC, cm_IL, cm_PI, cm_PL, cm_TD, cm_TA,
		cm_TB, cm_MB, cm_MD, cm_RW, cm_MM, cm_MW,
		cm_MS, cm_FS, cm_NA
	);
	
	zf_I <= IR_SB;
	comp_zfill: zerofill port map (
		zf_I, zf_O
	);
	
	const_0 <= '0';
	const_1 <= '1';
	not_C <= not C;
	not_Z <= not Z;
	comp_mux8: mux8_1 port map (
		const_0, const_1, C, V, Z, N, not_C, not_Z, m8_MS(0), m8_MS(1), m8_MS(2), m8_O
	);
	
	m2_NA <= cm_NA;
	m2_OP <= IR_OP;
	m2_MC <= cm_MC;
	comp_mux2: mux2_8 port map (
		m2_NA, m2_OP, m2_MC, m2_O
	);
	
end behave;
