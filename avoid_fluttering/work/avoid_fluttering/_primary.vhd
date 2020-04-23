library verilog;
use verilog.vl_types.all;
entity avoid_fluttering is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key_in          : in     vl_logic;
        key_out         : out    vl_logic
    );
end avoid_fluttering;
