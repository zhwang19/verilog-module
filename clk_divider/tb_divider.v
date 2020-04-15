
`timescale 1ns/1ps

module tb_divider;
	
	reg 			clk_in;
	reg 			rst_n;
	wire			clk_out_even;
	wire			clk_out_odd;

	initial clk_in = 0;
	always #10 clk_in = ~clk_in;

	initial begin
		rst_n = 0;
		#200
		rst_n = 1;
		
	end

	even_divider inst_even_divider (
		.clk_in(clk_in),
		.rst_n(rst_n),
		.clk_out_even(clk_out_even)
		);
	odd_divider inst_odd_divider (
		.clk_in(clk_in),
		.rst_n(rst_n),
		.clk_out_odd(clk_out_odd)
		);
endmodule