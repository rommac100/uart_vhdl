-- Simple uart_transmitter

--- curr_state represents the state that the uart_trans is in 
--- Mealy machine is used.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_trans is
	port (
		o_tx : out std_logic;
		o_curr_state : out std_logic_vector (1 downto 0);
		o_clk_bit_cnt : out integer range 0 to 15;
		i_clk: in std_logic;
		i_byte: in std_logic_vector (7 downto 0);
		i_send_byte: in std_logic;
		o_bit_index: out integer range 0 to 7
	);
end uart_trans;

architecture arch of uart_trans is
	signal clk_bit_cnt : integer range 0 to 15 		:=0;
	signal curr_state : std_logic_vector (1 downto 0) 	:= "00"; 
	signal bit_index : integer range 0 to 7 		:=0;
	signal rst_clk_cnt : std_logic := '0';
begin
	o_clk_bit_cnt <= clk_bit_cnt;
	--- State Process:
	--- 00 == idle state waiting for send_byte input
	--- 01 == sending start signal
        --- 10 == sending data signal
	--- 11 == sending stop signal	
	process (i_clk, rst_clk_cnt)
	begin
		if rising_edge (rst_clk_cnt) or clk_bit_cnt=15 then
			clk_bit_cnt <= 0;
			rst_clk_cnt <= '0';
		elsif rising_edge (i_clk) then
			clk_bit_cnt <= clk_bit_cnt + 1;
		end if;
	end process;

	process (i_clk)
	begin
		o_curr_state <= curr_state;
		o_bit_index <= bit_index;	
		case curr_state is
			when "00" =>
				o_tx <= '1';
				if (i_send_byte='1') then
					curr_state <= "01";
					rst_clk_cnt <= '1';
				else 
					curr_state<= "00";
				end if;
			when "01" =>
				o_tx <= '0';
				if clk_bit_cnt=15 then
					curr_state <= "10";
					bit_index <= 0; 
					rst_clk_cnt <= '1';
				else
					curr_state <= "01";
				end if;
			when "10" =>
				rst_clk_cnt <= '0';
				if clk_bit_cnt=15 then
					if bit_index=7 then
						curr_state <= "11";
					else
						bit_index <= bit_index+1;
					end if;
					rst_clk_cnt <= '1';
				else
					o_tx <= i_byte(bit_index);
				end if;
			when "11" =>
				if (clk_bit_cnt=15) then
					bit_index <= 0;
					curr_state <= "00";
				o_tx <= '1';
				end if;
			when others =>
				o_tx <= '1';
		end case;
	end process;
end arch;
