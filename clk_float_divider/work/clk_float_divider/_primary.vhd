library verilog;
use verilog.vl_types.all;
entity clk_float_divider is
    port(
        clk_in          : in     vl_logic;
        rst_n           : in     vl_logic;
        clk_out         : out    vl_logic
    );
end clk_float_divider;
