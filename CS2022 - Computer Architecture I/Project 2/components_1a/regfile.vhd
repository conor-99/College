-- Register File
-- Modified version of the one from Project 1B

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regfile is
	port(
		src_A0, src_A1, src_A2, src_A3: in std_logic;
		src_B0, src_B1, src_B2, src_B3: in std_logic;
		des_A0, des_A1, des_A2, des_A3: in std_logic;
		Clk, RW: in std_logic;
		data: in std_logic_vector (15 downto 0);
		data_A, data_B: out std_logic_vector (15 downto 0)
	);
end regfile;

architecture behave of regfile is
	
	component reg
	port(
		D: in std_logic_vector (15 downto 0);
		load, reg_rw, Clk: in std_logic;
		Q: out std_logic_vector (15 downto 0)
	);
	end component;
	
	component dec16
	port(
		A0, A1, A2, A3: in std_logic;
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15: out std_logic
	);
	end component;
	
	component mux16
	port(
		in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15: in std_logic_vector (15 downto 0);
		s0, s1, s2, s3: in std_logic;
		z: out std_logic_vector (15 downto 0)
	);
	end component;
	
	signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7, load_reg8: std_logic;
	signal reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q, reg8_q, reg_A, reg_B: std_logic_vector (15 downto 0);
	
	constant delay: Time := 5ns;
	
begin
	
	-- reg0
	reg00: reg port map(
		D => data,
		load => load_reg0,
		reg_rw => RW,
		Clk => Clk,
		Q => reg0_q
	);
	-- reg1
	reg01: reg port map(
		D => data,
		load => load_reg1,
		reg_rw => RW,
		Clk => Clk,
		Q => reg1_q
	);
	-- reg2
	reg02: reg port map(
		D => data,
		load => load_reg2,
		reg_rw => RW,
		Clk => Clk,
		Q => reg2_q
	);
	-- reg3
	reg03: reg port map(
		D => data,
		load => load_reg3,
		reg_rw => RW,
		Clk => Clk,
		Q => reg3_q
	);
	-- reg4
	reg04: reg port map(
		D => data,
		load => load_reg4,
		reg_rw => RW,
		Clk => Clk,
		Q => reg4_q
	);
	-- reg5
	reg05: reg port map(
		D => data,
		load => load_reg5,
		reg_rw => RW,
		Clk => Clk,
		Q => reg5_q
	);
	-- reg6
	reg06: reg port map(
		D => data,
		load => load_reg6,
		reg_rw => RW,
		Clk => Clk,
		Q => reg6_q
	);
	-- reg7
	reg07: reg port map(
		D => data,
		load => load_reg7,
		reg_rw => RW,
		Clk => Clk,
		Q => reg7_q
	);
	-- reg8
	reg08: reg port map(
		D => data,
		load => load_reg8,
		reg_rw => RW,
		Clk => Clk,
		Q => reg8_q
	);
	-- decoder
	des_dec: dec16 port map(
		A0 => des_A0,
		A1 => des_A1,
		A2 => des_A2,
		A3 => des_A3,
		Q0 => load_reg0,
		Q1 => load_reg1,
		Q2 => load_reg2,
		Q3 => load_reg3,
		Q4 => load_reg4,
		Q5 => load_reg5,
		Q6 => load_reg6,
		Q7 => load_reg7,
		Q8 => load_reg8,
		Q9 => load_reg8,
		Q10 => load_reg8,
		Q11 => load_reg8,
		Q12 => load_reg8,
		Q13 => load_reg8,
		Q14 => load_reg8,
		Q15 => load_reg8
	);
	-- reg mux A
	reg_mux_A: mux16 port map(
		in0 => reg0_q,
		in1 => reg1_q,
		in2 => reg2_q,
		in3 => reg3_q,
		in4 => reg4_q,
		in5 => reg5_q,
		in6 => reg6_q,
		in7 => reg7_q,
		in8 => reg8_q,
		in9 => reg8_q,
		in10 => reg8_q,
		in11 => reg8_q,
		in12 => reg8_q,
		in13 => reg8_q,
		in14 => reg8_q,
		in15 => reg8_q,
		s0 => src_A0,
		s1 => src_A1,
		s2 => src_A2,
		s3 => src_A3,
		z => reg_A
	);
	-- reg mux B
	reg_mux_B: mux16 port map(
		in0 => reg0_q,
		in1 => reg1_q,
		in2 => reg2_q,
		in3 => reg3_q,
		in4 => reg4_q,
		in5 => reg5_q,
		in6 => reg6_q,
		in7 => reg7_q,
		in8 => reg8_q,
		in9 => reg8_q,
		in10 => reg8_q,
		in11 => reg8_q,
		in12 => reg8_q,
		in13 => reg8_q,
		in14 => reg8_q,
		in15 => reg8_q,
		s0 => src_B0,
		s1 => src_B1,
		s2 => src_B2,
		s3 => src_B3,
		z => reg_B
	);
	data_A <= reg_A;
	data_B <= reg_B;
end behave;
