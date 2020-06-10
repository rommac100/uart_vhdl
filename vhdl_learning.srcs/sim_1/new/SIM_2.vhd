library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library axi_iic_0;
library unisim;

entity SIM_2 is
	port(
		interupt : out std_logic_vector(7 downto 0);
		sr 	 : out std_logic_vector(7 downto 0)
	);
end SIM_2;

architecture sim of SIM_2 is
	component axi_iic
		generic (
	    	C_FAMILY             : string;
		    C_S_AXI_ADDR_WIDTH   : integer;
		    C_S_AXI_DATA_WIDTH   : integer range 32 to 32;
		    C_IIC_FREQ           : integer;
		    C_TEN_BIT_ADR        : integer;
		    C_GPO_WIDTH          : integer;
		    C_S_AXI_ACLK_FREQ_HZ : integer;
		    C_SCL_INERTIAL_DELAY : integer;
		    C_SDA_INERTIAL_DELAY : integer;
		    C_SDA_LEVEL          : integer;
		    C_SMBUS_PMBUS_HOST   : integer;
		    C_DEFAULT_VALUE      : std_logic_vector(7 downto 0));
		port (
		    s_axi_aclk    : in  std_logic;
		    s_axi_aresetn : in  std_logic := '1';
		    iic2intc_irpt : out std_logic;
		    s_axi_awaddr  : in  std_logic_vector (8 downto 0);
		    s_axi_awvalid : in  std_logic;
		    s_axi_awready : out std_logic;
		    s_axi_wdata   : in  std_logic_vector (31 downto 0);
		    s_axi_wstrb   : in  std_logic_vector (3 downto 0);
		    s_axi_wvalid  : in  std_logic;
		    s_axi_wready  : out std_logic;
		    s_axi_bresp   : out std_logic_vector(1 downto 0);
		    s_axi_bvalid  : out std_logic;
		    s_axi_bready  : in  std_logic;
		    s_axi_araddr  : in  std_logic_vector(8 downto 0);
		    s_axi_arvalid : in  std_logic;
		    s_axi_arready : out std_logic;
		    s_axi_rdata   : out std_logic_vector (31 downto 0);
		    s_axi_rresp   : out std_logic_vector(1 downto 0);
		    s_axi_rvalid  : out std_logic;
		    s_axi_rready  : in  std_logic;
		    sda_i         : in  std_logic;
		    sda_o         : out std_logic;
		    sda_t         : out std_logic;
		    scl_i         : in  std_logic;
		    scl_o         : out std_logic;
		    scl_t         : out std_logic;
		    gpo           : out std_logic_vector(0 downto 0));
	    end component;	

	    -- component ports
	    signal s_axi_aclk    : std_logic := '0';
	    signal s_axi_aresetn : std_logic := '1';
	    signal iic2intc_irpt : std_logic;
	    signal s_axi_awaddr  : std_logic_vector (8 downto 0);
	    signal s_axi_awvalid : std_logic := '0';
	    signal s_axi_awready : std_logic;
	    signal s_axi_wdata   : std_logic_vector (31 downto 0);
	    signal s_axi_wstrb   : std_logic_vector (3 downto 0);
	    signal s_axi_wvalid  : std_logic := '0';
	    signal s_axi_wready  : std_logic;
	    signal s_axi_bresp   : std_logic_vector(1 downto 0);
	    signal s_axi_bvalid  : std_logic;
	    signal s_axi_bready  : std_logic := '0';
	    signal s_axi_araddr  : std_logic_vector(8 downto 0);
	    signal s_axi_arvalid : std_logic := '0';
	    signal s_axi_arready : std_logic;
	    signal s_axi_rdata   : std_logic_vector (31 downto 0);
	    signal s_axi_rresp   : std_logic_vector(1 downto 0);
	    signal s_axi_rvalid  : std_logic := '0';
	    signal s_axi_rready  : std_logic;
	    signal sda_o         : std_logic;
	    signal sda_t         : std_logic;
	    signal sda_io        : std_logic;
	    signal scl_o         : std_logic;
	    signal scl_t         : std_logic;
	    signal scl_io        : std_logic;
	    signal gpo           : std_logic_vector(0 downto 0);
begin
	DUT : entity axi_iic_0.axi_iic(rtl)
        generic map (
            C_FAMILY             => "artix7",
            C_S_AXI_ADDR_WIDTH   => 9,
            C_S_AXI_DATA_WIDTH   => 32,
            C_IIC_FREQ           => 100000,
            C_TEN_BIT_ADR        => 0,
            C_GPO_WIDTH          => 1,
            C_S_AXI_ACLK_FREQ_HZ => 62500000,
            C_SCL_INERTIAL_DELAY => 0,
            C_SDA_INERTIAL_DELAY => 0,
            C_SDA_LEVEL          => 1,
            C_SMBUS_PMBUS_HOST   => 0,
            C_DEFAULT_VALUE      => X"00"
            )
        port map (
            s_axi_aclk    => s_axi_aclk,
            s_axi_aresetn => s_axi_aresetn,
            iic2intc_irpt => iic2intc_irpt,
            s_axi_awaddr  => s_axi_awaddr,
            s_axi_awvalid => s_axi_awvalid,
            s_axi_awready => s_axi_awready,
            s_axi_wdata   => s_axi_wdata,
            s_axi_wstrb   => s_axi_wstrb,
            s_axi_wvalid  => s_axi_wvalid,
            s_axi_wready  => s_axi_wready,
            s_axi_bresp   => s_axi_bresp,
            s_axi_bvalid  => s_axi_bvalid,
            s_axi_bready  => s_axi_bready,
            s_axi_araddr  => s_axi_araddr,
            s_axi_arvalid => s_axi_arvalid,
            s_axi_arready => s_axi_arready,
            s_axi_rdata   => s_axi_rdata,
            s_axi_rresp   => s_axi_rresp,
            s_axi_rvalid  => s_axi_rvalid,
            s_axi_rready  => s_axi_rready,
            sda_i         => sda_io,
            sda_o         => sda_o,
            sda_t         => sda_t,
            scl_i         => scl_io,
            scl_o         => scl_o,
            scl_t         => scl_t,
            gpo           => gpo);

end sim;
