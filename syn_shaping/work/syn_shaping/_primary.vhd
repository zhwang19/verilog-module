library verilog;
use verilog.vl_types.all;
entity syn_shaping is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        din             : in     vl_logic;
        dout            : out    vl_logic
    );
end syn_shaping;
