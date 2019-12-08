-- Register File (TLS)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regfile is
	port(
		src_s0, src_s1, src_s2: in std_logic;
		des_A0, des_A1, des_A2: in std_logic;
		Clk: in std_logic;
		data_src: in std_logic;
		data: in std_logic_vector (3 downto 0);
		reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7: out std_logic_vector (3 downto 0)
	);
end regfile;

architecture behave of regfile is
-- components
	-- register
	component reg
	port(
		D: in std_logic_vector (3 downto 0);
		load, Clk: in std_logic;
		Q: out std_logic_vector (3 downto 0)
	);
	end component;
	-- 3-to-8 decoder
	component dec8
	port(
		A0, A1, A2: in std_logic;
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7: out std_logic
	);
	end component;
	-- 8-to-1 multiplexer
	component mux8
	port(
		in0, in1, in2, in3, in4, in5, in6, in7: in std_logic_vector (3 downto 0);
		s0, s1, s2: in std_logic;
		z: out std_logic_vector (3 downto 0)
	);
	end component;
	-- 2-to-1 multiplexer
	component mux2
	port(
		in0, in1: in std_logic_vector (3 downto 0);
		s: in std_logic;
		z: out std_logic_vector (3 downto 0)
	);
	end component;
	-- signals
	signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7: std_logic;
	signal reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q, data_src_mux_out, src_reg: std_logic_vector (3 downto 0);
	-- constants
	constant delay: Time := 5ns;
begin
	-- port maps
	-- reg0
	reg00: reg port map(
		D => data_src_mux_out,
		load => load_reg0,
		Clk => Clk,
		Q => reg0_q
	);
	-- reg1
	reg01: reg port map(
		D => data_src_mux_out,
		load => load_reg1,
		Clk => Clk,
		Q => reg1_q
	);
	-- reg2
	reg02: reg port map(
		D => data_src_mux_out,
		load => load_reg2,
		Clk => Clk,
		Q => reg2_q
	);
	-- reg3
	reg03: reg port map(
		D => data_src_mux_out,
		load => load_reg3,
		Clk => Clk,
		Q => reg3_q
	);
	-- reg4
	reg04: reg port map(
		D => data_src_mux_out,
		load => load_reg4,
		Clk => Clk,
		Q => reg4_q
	);
	-- reg5
	reg05: reg port map(
		D => data_src_mux_out,
		load => load_reg5,
		Clk => Clk,
		Q => reg5_q
	);
	-- reg6
	reg06: reg port map(
		D => data_src_mux_out,
		load => load_reg6,
		Clk => Clk,
		Q => reg6_q
	);
	-- reg7
	reg07: reg port map(
		D => data_src_mux_out,
		load => load_reg7,
		Clk => Clk,
		Q => reg7_q
	);
	-- decoder
	des_dec: dec8 port map(
		A0 => des_A0,
		A1 => des_A1,
		A2 => des_A2,
		Q0 => load_reg0,
		Q1 => load_reg1,
		Q2 => load_reg2,
		Q3 => load_reg3,
		Q4 => load_reg4,
		Q5 => load_reg5,
		Q6 => load_reg6,
		Q7 => load_reg7
	);
	-- src mux
	src_mux: mux2 port map(
		in0 => data,
		in1 => src_reg,
		s => data_src,
		z => data_src_mux_out
	);
	-- src reg mux
	reg_mux: mux8 port map(
		in0 => reg0_q,
		in1 => reg1_q,
		in2 => reg2_q,
		in3 => reg3_q,
		in4 => reg4_q,
		in5 => reg5_q,
		in6 => reg6_q,
		in7 => reg7_q,
		s0 => src_s0,
		s1 => src_s1,
		s2 => src_s2,
		z => src_reg
	);
	reg0 <= reg0_q;
	reg1 <= reg1_q;
	reg2 <= reg2_q;
	reg3 <= reg3_q;
	reg4 <= reg4_q;
	reg5 <= reg5_q;
	reg6 <= reg6_q;
	reg7 <= reg7_q;
end behave;
