
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_interface is
	port (a,b: in std_logic;
	     c   : out std_logic);
end test_interface;

architecture Behavioral of test_interface is
begin
	c <= (a xor b);
end Behavioral;
