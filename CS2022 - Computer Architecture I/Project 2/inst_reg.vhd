-- Instruction Register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity inst_reg is
	port(
		ins_I: in std_logic_vector (15 downto 0);
		IL: in std_logic;
		DR, SA, SB: out std_logic_vector (2 downto 0);
		op_O: out std_logic_vector (6 downto 0)
	);
end inst_reg;

architecture behave of inst_reg is
	constant delay: Time := 2ns;
begin
	SB <= ins_I(2 downto 0) after delay when IL = '1';
	SA <= ins_I(5 downto 3) after delay when IL = '1';
	DR <= ins_I(8 downto 6) after delay when IL = '1';
	op_O <= ins_I(15 downto 9) after delay when IL = '1';
end behave;
