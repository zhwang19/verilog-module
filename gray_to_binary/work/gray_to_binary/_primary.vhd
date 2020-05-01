library verilog;
use verilog.vl_types.all;
entity gray_to_binary is
    generic(
        PTR             : integer := 8
    );
    port(
        gray_value      : in     vl_logic_vector;
        binary_value    : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PTR : constant is 1;
end gray_to_binary;
