library IEEE, xc4000;
use IEEE.STD_LOGIC_1164.ALL;

library axi_iic_v2_0_11;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_ARITH.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IIC_SIM is
end IIC_SIM;

architecture Behavioral of IIC_SIM is
	component axi_iic_0
		PORT (
		    s_axi_aclk : IN STD_LOGIC;
		    s_axi_aresetn : IN STD_LOGIC;
		    iic2intc_irpt : OUT STD_LOGIC;
		    s_axi_awaddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		    s_axi_awvalid : IN STD_LOGIC;
		    s_axi_awready : OUT STD_LOGIC;
		    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		    s_axi_wvalid : IN STD_LOGIC;
		    s_axi_wready : OUT STD_LOGIC;
		    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		    s_axi_bvalid : OUT STD_LOGIC;
		    s_axi_bready : IN STD_LOGIC;
		    s_axi_araddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		    s_axi_arvalid : IN STD_LOGIC;
		    s_axi_arready : OUT STD_LOGIC;
		    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		    s_axi_rvalid : OUT STD_LOGIC;
		    s_axi_rready : IN STD_LOGIC;
		    sda_i : IN STD_LOGIC;
		    sda_o : OUT STD_LOGIC;
		    sda_t : OUT STD_LOGIC;
		    scl_i : IN STD_LOGIC;
		    scl_o : OUT STD_LOGIC;
		    scl_t : OUT STD_LOGIC;
		    gpo : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
		  );
	end component;

	component PULLUP
		PORT (O: out std_logic);
	end component;

	--- Signals
	signal clk: std_ulogic := '0';

	signal reset: std_logic := '1';
	signal iic2intc_irpt: std_logic;
	signal awaddr: std_logic_vector (8 DOWNTO 0) := "000000000";
	signal awvalid: std_logic := '0';
	signal awready: std_logic;
	signal wdata: std_logic_vector (31 DOWNTO 0) := x"00000000";
	signal wstrb: std_logic_vector (3 DOWNTO 0) := "0000";
	signal wvalid: std_logic := '0';
	signal wready: std_logic;
	signal bresp: std_logic_vector (1 DOWNTO 0);
	signal bvalid: std_logic;
	signal bready: std_logic := '0';
	signal araddr: std_logic_vector (8 DOWNTO 0);
	signal arvalid: std_logic := '0';
	signal arready: std_logic;
	signal rdata: std_logic_vector (31 DOWNTO 0);
	signal rresp: std_logic_vector (1 DOWNTO 0);
	signal rvalid: std_logic;
	signal rready: std_logic := '0';
	signal sda_i : std_logic := '0';
	signal sda_o : std_logic;
	signal sda_t : std_logic := '0';
	signal scl_i : std_logic := '0';
	signal scl_o : std_logic;
	signal scl_t : std_logic := '0';
	signal gpo : std_logic_vector (0 DOWNTO 0);

	signal scl_io : std_logic;
	signal sda_io : std_logic;

begin
	clk <= not clk after 2.5 ns;

	uut : axi_iic_0
		port map (clk,reset,iic2intc_irpt,awaddr,awvalid,awready,wdata,wstrb,wvalid,wready,bresp,bvalid,bready,araddr,arvalid,arready,rdata,rresp,rvalid,rready,sda_i,sda_o,sda_t,scl_i,scl_o,scl_t, gpo);
	
	scl_io <= 'Z' when (scl_t = '1') else scl_o;
	sda_io <= 'Z' when (sda_t = '1') else sda_o;

	scl_pull : PULLUP
		port map (O=> scl_io);
	
	sda_pull : PULLUP
		port map (O=> sda_io);

	stim_proc : process
	begin
		reset <= '0';
	 	wait for 5 ns;
		reset <= '1';
		wait until rising_edge(clk);
		awaddr <= "001100000";
		wvalid <= '1';
		awvalid <= '1';
		bready <= '1';
		wdata <= x"00000001";
		arvalid <= '0';
		rready <= '0';
		scl_t <='0';
		sda_t <='0';
		while (awready = '0') or (wready = '0')
		loop
			wait until rising_edge (clk);
			awvalid <= not awready;
			wvalid <= not wready;
			bready <= not bvalid;
		end loop;
		bready <= not bvalid;

		wait until rising_edge(clk);
		bready <= not bvalid;
		awaddr <= (others => '0');
		wdata <= (others => '0'); 
		awvalid <= '0';
		wvalid <= '0';

		wait;
	end process;

end Behavioral;
