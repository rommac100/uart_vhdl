-- 4-bit adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fourbitadder is
	port (a, b : in std_logic_vector(3 downto 0);
	c_in : in std_logic;
	sum: out std_logic_vector(3 downto 0);
	c_out, V: out std_logic);
end fourbitadder;

architecture fourbitadder_structure of fourbitadder is
	signal c: std_logic_vector (4 downto 0);
	component FULLADDER 
		port(a,b,c_in: in std_logic;
		sum, c_out: out std_logic);
	end component;
begin
	FULLADD0: FULLADDER
		port map(a(0), b(0), c_in, sum(0), c(1));
	FULLADD1: FULLADDER
		port map(a(1), b(1), c(1), sum(1), c(2));
	FULLADD2: FULLADDER
		port map(a(2), b(2), c(2), sum(2), c(3));
	FULLADD3: FULLADDER
		port map(a(3), b(3), c(3), sum(3), c(4));
	V <= c(3) xor c(4);
	c_out <= c(4);
end fourbitadder_structure;
