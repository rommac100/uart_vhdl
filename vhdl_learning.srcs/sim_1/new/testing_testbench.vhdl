library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testing_testbench is 
end testing_testbench;

architecture arch of testing_testbench is
	--- components	
	component uart_trans
		port (
			i_rx : in std_logic; 
			o_tx : out std_logic;
			o_curr_state : out std_logic_vector (1 downto 0);
			o_clk_bit_cnt : out integer range 0 to 15;
			i_clk: in std_logic;
			i_byte: in std_logic_vector (7 downto 0);
			i_send_byte: in std_logic;
			o_bit_index: out integer range 0 to 7
		);
	end component;

	--- signals
	signal s_rx : std_logic 				:= '0';
	signal s_tx : std_logic 				:= '1';
	signal s_curr_state: std_logic_vector ( 1 downto 0) 	:= "00";
	signal clk : std_logic 					:= '0';
	signal s_byte : std_logic_vector (7 downto 0) 		:= x"00";
	signal s_send_byte : std_logic 				:= '0';
	signal s_clk_bit_cnt : integer range 0 to 15; 
	signal s_bit_ind : integer range 0 to 7;
begin
	--- clock generation
	--- attempting to generate a 9600 baud with a 16 sampling rate

	uut: uart_trans
		port map (s_rx,s_tx,s_curr_state,s_clk_bit_cnt,clk,s_byte,s_send_byte,s_bit_ind);
	clk <= not clk after 5425 ns;

	process
	begin
		wait for 1 ms;	
		s_byte <= x"01";
		s_send_byte <= '1';
		wait for 10 ms;
		wait;
	end process;

end arch;
