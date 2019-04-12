-- ALU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
	port(
		-- G select
		G: in std_logic_vector (3 downto 0);
		-- Clock
		Clk: in std_logic;
		-- A data, B data
		data_A, data_B: in std_logic_vector (3 downto 0);
		-- Flags
		V, C: out std_logic;
		-- Output data
		data_O: out std_logic_vector (3 downto 0)
	);
end alu;

architecture behave of alu is
	component rippleadder16
		port(
			B, A: in std_logic_vector (15 downto 0);
			CI: in std_logic;
			S: out std_logic_vector (15 downto 0);
			CO: out std_logic
		);
	end component;
	signal ra_a, ra_b, ra_s: std_logic_vector (15 downto 0);
	signal ra_ci, ra_co: std_logic;
	constant delay: Time := 1ns;
begin
	fa: rippleadder16 port map (ra_a, ra_b, ra_ci, ra_s, ra_co);
	process(Clk)
	begin
		if (rising_edge(Clk)) then

			case G is
				-- O = A
				when "0000" =>
					ra_a <= data_A;
					ra_b <= x"0000";
					ra_ci <= '0';
				-- O = A + 1
				when "0001" =>
					ra_a <= data_A;
					ra_b <= x"0001";
					ra_ci <= '0';
				-- O = A + B
				when "0010" =>
					ra_a <= data_A;
					ra_b <= data_B;
					ra_ci <= '0';
				-- O = A + B + 1
				when "0011" =>
					ra_a <= data_A;
					ra_b <= data_B;
					ra_ci <= '1';
				-- O = A + ~B
				when "0100" =>
					ra_a <= data_A;
					ra_b <= not data_B;
					ra_ci <= '0';
				-- O = A + ~B + 1
				when "0101" =>
					ra_a <= data_A;
					ra_b <= not data_B;
					ra_ci <= '1';
					-- fa(A, ~B, 1)
				-- O = A - 1 = A + (-1)
				when "0110" =>
					ra_a <= data_A;
					ra_b <= x"FFFF";
					ra_ci <= '0';
				-- O = A
				when "0111" =>
					ra_a <= data_A;
					ra_b <= x"0000";
					ra_ci <= '0';
				-- O = A AND B
				when "1000" =>
					ra_a <= data_A and data_B;
					ra_b <= x"0000";
					ra_ci <= '0';
				-- O = A OR B
				when "1010" =>
					ra_a <= data_A or data_B;
					ra_b <= x"0000";
					ra_ci <= '0';
				-- O = A XOR B
				when "1100" =>
					ra_a <= data_A xor data_B;
					ra_b <= x"0000";
					ra_ci <= '0';
				-- O = ~A
				when "1110" =>
					ra_a <= not data_A;
					ra_b <= x"0000";
					ra_ci <= '0';
				-- O = A
				when others =>
					ra_a <= data_A;
					ra_b <= x"0000";
					ra_ci <= '0';
			end case;

		end if;
	end process;
end behave;
