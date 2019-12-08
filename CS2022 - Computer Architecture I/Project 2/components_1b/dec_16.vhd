-- 4-to-16 Decoder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec16 is
	port(
		A0, A1, A2, A3: in std_logic;
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15: out std_logic
	);
end dec16;

architecture behave of dec16 is
constant delay: Time := 5ns;
begin
	Q0 <= ((not A0) and (not A1) and (not A2) and (not A3)) after delay;
	Q1 <= ((not A0) and (not A1) and (not A2) and A3) after delay;
	Q2 <= ((not A0) and (not A1) and A2 and (not A3)) after delay;
	Q3 <= ((not A0) and (not A1) and A2 and A3) after delay;
	Q4 <= ((not A0) and A1 and (not A2) and (not A3)) after delay;
	Q5 <= ((not A0) and A1 and (not A2) and A3) after delay;
	Q6 <= ((not A0) and A1 and A2 and (not A3)) after delay;
	Q7 <= ((not A0) and A1 and A2 and A3) after delay;
	Q8 <= (A0 and (not A1) and (not A2) and (not A3)) after delay;
	Q9 <= (A0 and (not A1) and (not A2) and A3) after delay;
	Q10 <= (A0 and (not A1) and A2 and (not A3)) after delay;
	Q11 <= (A0 and (not A1) and A2 and A3) after delay;
	Q12 <= (A0 and A1 and (not A2) and (not A3)) after delay;
	Q13 <= (A0 and A1 and (not A2) and A3) after delay;
	Q14 <= (A0 and A1 and A2 and (not A3)) after delay;
	Q15 <= (A0 and A1 and A2 and A3) after delay;
end behave;
