-- Control Memory (256 x 28)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_memory is
	port(
		car_I: in std_logic_vector (7 downto 0);
		MC, IL, PI, PL, TD, TA: out std_logic;
		TB, MB, MD, RW, MM, MW: out std_logic;
		MS: out std_logic_vector (2 downto 0);
		FS: out std_logic_vector (4 downto 0);
		NA: out std_logic_vector (7 downto 0)
	);
end control_memory;

architecture behave of control_memory is
	type mem_array is array(0 to 255) of std_logic_vector(27 downto 0);
begin
	mem_process: process(car_I)
	variable mem: mem_array := (
		-- 0
		x"0000000", -- ADI
		x"0000000", -- LDR
		x"0000000", -- STR
		x"0000000", -- INC
		x"0000000", -- NOT
		x"0000000", -- ADD
		x"0000000", -- JMP
		x"0000000", -- JMC
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 1
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 2
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 3
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 4
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 5
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 6
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 7
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 8
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- 9
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- A
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- B
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- C
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- D
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- E
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		-- F
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000",
		x"0000000", x"0000000", x"0000000", x"0000000"
	);

	variable addr_C: integer;
	variable cntl_O: std_logic_vector (27 downto 0);
	
	begin
		addr_C := conv_integer(car_I);
		cntl_O := mem(addr_C);
		MW <= cntl_O(0);
		MM <= cntl_O(1);
		RW <= cntl_O(2);
		MD <= cntl_O(3);
		FS <= cntl_O(8 downto 4);
		MB <= cntl_O(9);
		TB <= cntl_O(10);
		TA <= cntl_O(11);
		TD <= cntl_O(12);
		PL <= cntl_O(13);
		PI <= cntl_O(14);
		IL <= cntl_O(15);
		MC <= cntl_O(16);
		MS <= cntl_O(19 downto 17);
		NA <= cntl_O(27 downto 20);
	end process;
	
end behave;
