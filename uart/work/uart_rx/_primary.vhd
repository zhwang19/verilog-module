library verilog;
use verilog.vl_types.all;
entity uart_rx is
    port(
        sclk            : in     vl_logic;
        rst_n           : in     vl_logic;
        rx              : in     vl_logic;
        rx_data         : out    vl_logic_vector(7 downto 0);
        po_flag         : out    vl_logic
    );
end uart_rx;
