library verilog;
use verilog.vl_types.all;
entity spi_module is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        tx_en           : in     vl_logic;
        rx_en           : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        data_out        : out    vl_logic_vector(7 downto 0);
        tx_done         : out    vl_logic;
        rx_done         : out    vl_logic;
        miso            : in     vl_logic;
        mosi            : out    vl_logic;
        cs_n            : out    vl_logic;
        sck             : out    vl_logic
    );
end spi_module;
