library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testing_vhdl is
	port(
		input_decode : in std_logic_vector (1 downto 0);
		enable : in std_logic;
		output : out std_logic_vector (3 downto 0)	
	);
end testing_vhdl;

architecture main_arch of testing_vhdl is
begin
	output <= "0000" when enable='0' 	   else
		  "0001" when (input_decode ="00") else
		  "0010" when (input_decode ="01") else
		  "0100" when (input_decode ="10") else
		  "1000"; 
end main_arch;
