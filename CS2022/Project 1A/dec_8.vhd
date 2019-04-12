-- 3-to-8 Decoder (4-bit)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec8 is
	port(
		A0, A1, A2: in std_logic;
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7: out std_logic
	);
end dec8;

architecture behave of dec8 is
constant delay: Time := 5ns;
begin
	Q0 <= ((not A0) and (not A1) and (not A2)) after delay;
	Q1 <= ((not A0) and (not A1) and A2) after delay;
	Q2 <= ((not A0) and A1 and (not A2)) after delay;
	Q3 <= ((not A0) and A1 and A2) after delay;
	Q4 <= (A0 and (not A1) and (not A2)) after delay;
	Q5 <= (A0 and (not A1) and A2) after delay;
	Q6 <= (A0 and A1 and (not A2)) after delay;
	Q7 <= (A0 and A1 and A2) after delay;
end behave;
