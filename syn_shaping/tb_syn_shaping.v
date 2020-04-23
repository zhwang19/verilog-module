
`timescale 1ns/1ps

module tb_syn_shaping;
	
	reg 					clk;
	reg 					rst_n;
	reg 					din;
	wire 					dout;

	initial clk = 0;
	always #10 clk = ~clk;

	initial begin
		rst_n 	<= 		1'b0;
		din		<=		1'b0;
		#200
		rst_n 	<= 		1'b1;
		#300
		din		<=		1'b1;
		#10
		din		<=		1'b0;
		
	end

	syn_shaping inst_syn_shaping (
		.clk(clk),
		.rst_n(rst_n),
		.din(din),
		.dout(dout)
		);

endmodule