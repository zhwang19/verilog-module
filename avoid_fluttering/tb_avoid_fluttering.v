
`timescale 1ns/1ps

module tb_avoid_fluttering;
	
	reg 				clk;
	reg 				rst_n;
	reg 				key_in;
	wire 				key_out;

	initial clk         = 0;
	always #5 clk       = ~clk;

	initial begin
		rst_n           <=  0;
		#200
		rst_n           <=  1;
		key_in          <=  0;
		repeat(20) begin
			#100 key_in <=  ~key_in;
		end
		#30000000
		key_in          <=  1;
		repeat(20) begin
			#100 key_in <=  ~key_in;
		end
	end

	avoid_fluttering inst_avoid_fluttering (
		.clk		(clk	)		,
		.rst_n		(rst_n	)		,
		.key_in		(key_in	)		,
		.key_out	(key_out)
		);

endmodule