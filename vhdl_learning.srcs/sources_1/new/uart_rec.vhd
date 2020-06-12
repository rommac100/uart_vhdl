--- UART RECEIVER: 
--- Should work just fine with any uart transmitting signal but for now use 9600 baud.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_rec is
	port (
		i_rx : in std_logic; 
		i_clk: in std_logic;
		o_bit_index: out integer range 0 to 7;
		o_curr_state : out std_logic_vector (1 downto 0);
		o_clk_bit_cnt : out integer range 0 to 15;
		o_byte : out std_logic_vector (7 downto 0)
	);
end uart_rec;

architecture Behavioral of uart_rec is
	signal clk_bit_cnt : integer range 0 to 15 		:=0;
	signal curr_state : std_logic_vector (1 downto 0) 	:= "00"; 
	signal bit_index : integer range 0 to 7 		:=0;
	signal rst_clk_cnt : std_logic 				:= '0';
	signal mid_start_signal : std_logic 			:= '0';
	signal s_byte : std_logic_vector (7 downto 0) 		:= x"00";
begin
	o_clk_bit_cnt <= clk_bit_cnt;
	o_curr_state <= curr_state;

	process (i_clk, rst_clk_cnt)
	begin
		if rising_edge (rst_clk_cnt) or clk_bit_cnt=15 then
			clk_bit_cnt <= 0;
			rst_clk_cnt <= '0';
		elsif rising_edge (i_clk) then
			clk_bit_cnt <= clk_bit_cnt + 1;
		end if;
	end process;

	process (i_clk, i_rx)
	begin
		case curr_state is
			when "00" =>
				if falling_edge (i_rx) then
					curr_state <= "01";
					rst_clk_cnt <= '1';
				end if;
			when "01" =>
				if clk_bit_cnt = 7 and mid_start_signal = '0' then 
					rst_clk_cnt <= '1';
					mid_start_signal<='1';
				elsif clk_bit_cnt=15 and mid_start_signal='1' then
					curr_state <= "10";
					rst_clk_cnt <= '1';
					mid_start_signal <= '0';
					bit_index <= 0;
				end if;
			when "10" =>
				if clk_bit_cnt = 15 then
					rst_clk_cnt <= '1';
					if bit_index =7 then
						curr_state <= "11";
					else
						bit_index <= bit_index +1;
					end if;
				else
					s_byte(bit_index) <= i_rx;
				end if;
			when "11" =>
				if clk_bit_cnt =7 then
					rst_clk_cnt <='1';
					curr_state <= "00";
					bit_index <= 0;
					o_byte <= s_byte;
				end if;
			when others =>
		end case;					
	end process;

end Behavioral;
