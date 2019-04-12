-- Function Unit
-- Taken from Project1B

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity func_unit is
	port(
		F: in std_logic_vector (4 downto 0);
		data_A, data_B: in std_logic_vector (15 downto 0);
		V, C, N, Z: out std_logic;
		data_O: out std_logic_vector (15 downto 0)
	);
end func_unit;

architecture behave of func_unit is

	component alu
		port(
			G: in std_logic_vector (3 downto 0);
			data_A, data_B: in std_logic_vector (15 downto 0);
			V, C: out std_logic;
			data_O: out std_logic_vector (15 downto 0)
		);
	end component;
	
	component shifter
		port(
			H: in std_logic_vector (1 downto 0);
			data_B: in std_logic_vector (15 downto 0);
			data_O: out std_logic_vector (15 downto 0)
		);
	end component;

	component mux2
		port(
			in0, in1: in std_logic_vector (15 downto 0);
			s: in std_logic;
			z: out std_logic_vector (15 downto 0)
		);
	end component;

	component zerodet
		port(
			data: in std_logic_vector (15 downto 0);
			Z: out std_logic
		);
	end component;
	
	signal MF: std_logic;
	signal G: std_logic_vector (3 downto 0);
	signal H: std_logic_vector (1 downto 0);
	signal alu_d_O: std_logic_vector (15 downto 0);
	signal sht_d_O: std_logic_vector (15 downto 0);

	constant delay: Time := 5ns;
	
begin
	
	comp_alu: alu port map (G, data_A, data_B, V, C, alu_d_O);
	comp_sht: shifter port map (H, data_B, sht_d_O);
	comp_mx2: mux2 port map (alu_d_O, sht_d_O, MF, data_O);
	comp_zdt: zerodet port map (alu_d_O, Z);
	
	MF <= F(4);
	G <= F(3 downto 0);
	H <= F(3 downto 2);
	N <= alu_d_O(15);
	
end behave;
