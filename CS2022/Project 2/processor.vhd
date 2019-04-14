-- Processor (TLS)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity processor is
	port(
		Clk, reset: in std_logic;
		proc_O: out std_logic_vector (15 downto 0)
	);
end processor;

architecture behave of processor is
	
	component microprog_control
		port(
			V, C, N, Z, Clk, reset: in std_logic;
			data_I: in std_logic_vector (15 downto 0);
			TD, TA, TB, MB, MD, RW, MM, MW: out std_logic;
			DR, SA, SB: out std_logic_vector (2 downto 0);
			FS: out std_logic_vector (4 downto 0);
			PC_O: out std_logic_vector (15 downto 0);
			zfill_O: out std_logic_vector (15 downto 0)
		);
	end component;

	signal c_data_I, c_PC_O, c_zf_O: std_logic_vector (15 downto 0);
	signal c_FS: std_logic_vector (4 downto 0);
	signal c_DR, c_SA, c_SB: std_logic_vector (2 downto 0);
	signal c_TD, c_TA, c_TB, c_MB, c_MD, c_RW, c_MM, c_MW, c_V, c_C, c_N, c_Z: std_logic;
	
	component datapath
		port(
			data_I, const_I, PC_I: in std_logic_vector (15 downto 0);
			F: in std_logic_vector (4 downto 0);
			dst_A, src_A, src_B: in std_logic_vector (3 downto 0);
			RW, MB, MD, MM, Clk: in std_logic;
			data_O, addr_O: out std_logic_vector (15 downto 0);
			V, C, N, Z: out std_logic
		);
	end component;
	
	signal d_data_I, d_const_I, d_PC_I, d_data_O, d_addr_O: std_logic_vector (15 downto 0);
	signal d_FS: std_logic_vector (4 downto 0);
	signal d_dst_A, d_src_A, d_src_B: std_logic_vector (3 downto 0);
	signal d_RW, d_MB, d_MD, d_MM, d_V, d_C, d_N, d_Z: std_logic;
	
	component memory
		port(
			data_I, addr_I: in std_logic_vector (15 downto 0);
			MW: in std_logic;
			data_O: out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal m_data_I, m_addr_I, m_data_O: std_logic_vector (15 downto 0);
	signal m_MW: std_logic;
	
begin
	
	c_V <= d_V;
	c_C <= d_C;
	c_N <= d_N;
	c_Z <= d_Z;
	c_data_I <= m_data_O;
	comp_mprog: microprog_control port map (
		c_V, c_C, c_N, c_Z, Clk, reset, c_data_I,
		c_TD, c_TA, c_TB, c_MB, c_MD, c_RW, c_MM, c_MW,
		c_DR, c_SA, c_SB, c_FS, c_PC_O, c_zf_O
	);

	d_data_I <= m_data_O;
	d_const_I <= c_zf_O;
	d_PC_I <= c_PC_O;
	d_FS <= c_FS;
	d_dst_A(2 downto 0) <= c_DR;
	d_dst_A(3) <= c_TD;
	d_src_A(2 downto 0) <= c_SA;
	d_src_A(3) <= c_TA;
	d_src_B(2 downto 0) <= c_SB;
	d_src_B(3) <= c_TB;
	d_RW <= c_RW;
	d_MB <= c_MB;
	d_MD <= c_MD;
	d_MM <= c_MM;
	comp_dpath: datapath port map (
		d_data_I, d_const_I, d_PC_I, d_FS,
		d_dst_A, d_src_A, d_src_B,
		d_RW, d_MB, d_MD, d_MM, Clk,
		d_data_O, d_addr_O,
		d_V, d_C, d_N, d_Z
	);
	
	m_data_I <= d_data_O;
	m_addr_I <= d_addr_O;
	m_MW <= c_MW;
	comp_mem: memory port map (
		m_data_I, m_addr_I, m_MW, m_data_O
	);

	proc_O <= m_data_O;
	
end behave;
