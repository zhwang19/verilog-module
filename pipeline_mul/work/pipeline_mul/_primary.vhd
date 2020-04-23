library verilog;
use verilog.vl_types.all;
entity pipeline_mul is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        mul_a           : in     vl_logic_vector(3 downto 0);
        mul_b           : in     vl_logic_vector(3 downto 0);
        mul_out         : out    vl_logic_vector(7 downto 0)
    );
end pipeline_mul;
