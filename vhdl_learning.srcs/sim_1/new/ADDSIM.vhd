library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADDSIM is
end ADDSIM;

architecture Behavioral of ADDSIM is
	component fourbitadder
		port (a, b : in std_logic_vector(3 downto 0);
		c_in : in std_logic;
		sum: out std_logic_vector(3 downto 0);
		c_out, V: out std_logic);
	end component;

	--- Signals
	signal a: std_logic_vector (3 downto 0) := "0000";
	signal b: std_logic_vector (3 downto 0) := "0000";
	signal c_in: std_logic  := '0';
	signal c_out: std_logic;
	signal sum: std_logic_vector (3 downto 0);
	signal V: std_logic;

	signal clk: std_ulogic := '0';
	
	--- Constants
begin
	clk <= not clk after 5 ps;
	FULL0: fourbitadder
		port map (a,b,c_in,sum,c_out, V);
	a <= "0000" after 10 ns;
	b <= "0001" after 10 ns;
end Behavioral;
