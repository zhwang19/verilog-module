library verilog;
use verilog.vl_types.all;
entity synch_fifo is
    generic(
        FIFO_PTR        : integer := 4;
        FIFO_WIDTH      : integer := 8;
        FIFO_DEPTH      : integer := 16
    );
    port(
        fifo_clk        : in     vl_logic;
        rst_n           : in     vl_logic;
        fifo_wren       : in     vl_logic;
        fifo_wrdata     : in     vl_logic_vector;
        fifo_rden       : in     vl_logic;
        fifo_rddata     : out    vl_logic_vector;
        fifo_full       : out    vl_logic;
        fifo_empty      : out    vl_logic;
        fifo_room_avail : out    vl_logic_vector;
        fifo_data_avail : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of FIFO_PTR : constant is 1;
    attribute mti_svvh_generic_type of FIFO_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of FIFO_DEPTH : constant is 1;
end synch_fifo;
