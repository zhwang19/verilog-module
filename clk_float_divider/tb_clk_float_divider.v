
`timescale 1ns/1ps

module tb_clk_float_divider;
	
	reg 				clk_in;
	reg 				rst_n;
	wire 				clk_out;

	initial clk_in = 0;
	always #10 clk_in = ~clk_in;

	initial begin
		rst_n = 0;
		#200
		rst_n = 1;
				
	end

	clk_float_divider inst_clk_float_divider (
		.clk_in(clk_in),
		.rst_n(rst_n),
		.clk_out(clk_out)
		);

endmodule