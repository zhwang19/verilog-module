library verilog;
use verilog.vl_types.all;
entity sequence_mul is
    port(
        clk             : in     vl_logic;
        en              : in     vl_logic;
        a               : in     vl_logic_vector(7 downto 0);
        b               : in     vl_logic_vector(7 downto 0);
        z               : out    vl_logic_vector(15 downto 0);
        z_flag          : out    vl_logic
    );
end sequence_mul;
