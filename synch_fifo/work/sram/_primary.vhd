library verilog;
use verilog.vl_types.all;
entity sram is
    generic(
        PTR             : integer := 4;
        WIDTH           : integer := 8;
        DEPTH           : integer := 16
    );
    port(
        wrclk           : in     vl_logic;
        wren            : in     vl_logic;
        wrptr           : in     vl_logic_vector;
        wrdata          : in     vl_logic_vector;
        rdclk           : in     vl_logic;
        rden            : in     vl_logic;
        rdptr           : in     vl_logic_vector;
        rddata          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PTR : constant is 1;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DEPTH : constant is 1;
end sram;
