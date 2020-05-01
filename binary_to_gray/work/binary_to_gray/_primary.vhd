library verilog;
use verilog.vl_types.all;
entity binary_to_gray is
    generic(
        PTR             : integer := 8
    );
    port(
        binary_value    : in     vl_logic_vector;
        gray_value      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PTR : constant is 1;
end binary_to_gray;
