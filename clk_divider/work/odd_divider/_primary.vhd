library verilog;
use verilog.vl_types.all;
entity odd_divider is
    port(
        clk_in          : in     vl_logic;
        rst_n           : in     vl_logic;
        clk_out_odd     : out    vl_logic
    );
end odd_divider;
