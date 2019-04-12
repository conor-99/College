-- Function Unit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity funcunit is
	port(
		-- F select
		F: in std_logic_vector (4 downto 0);
		-- Clock
		Clk: in std_logic;
		-- A data, B data
		data_A, data_B: in std_logic_vector (3 downto 0);
		-- Flags
		V, C, N, Z: out std_logic;
		-- Output data
		data_O: out std_logic_vector (3 downto 0)
	);
end funcunit;

architecture behave of funcunit is
-- components
	-- alu
	-- shifter
	-- mux2
	-- zero detect
	-- signals
	--signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7: std_logic;
	--signal reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q, reg_A, reg_B: std_logic_vector (3 downto 0);
	-- constants
	constant delay: Time := 5ns;
begin
	-- to-do
end behave;
