library verilog;
use verilog.vl_types.all;
entity even_divider is
    port(
        clk_in          : in     vl_logic;
        rst_n           : in     vl_logic;
        clk_out_even    : out    vl_logic
    );
end even_divider;
