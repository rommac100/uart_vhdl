library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- single bit adder 
entity FULLADDER is
	port (a,b,c_in: in std_logic;
	sum, c_out: out std_logic);
end FULLADDER;

architecture Behavioral of FULLADDER is
begin
	sum <= (a xor b) xor c_in ;
	c_out <= (a or b) or (c_in and (a xor b)) ;
end Behavioral;
