
`timescale 1ns/1ps

module tb_pipeline_mul;
	
	reg 						clk;
	reg 						rst_n;
	reg 		[3:0] 			mul_a;
	reg 		[3:0] 			mul_b;
	wire		[7:0] 			mul_out;

	initial 					clk = 	0;
	always 		#10 			clk = 	~clk;

	initial begin
		rst_n 						= 	1'b0;
		mul_a						=	0;
		mul_b						=	0;
		#200
		rst_n 						= 	1'b1;
		mul_a						=	4'ha;
		mul_b						=	4'ha;
		#300
		rst_n 						=	1'b0;
		#200
		rst_n 						=	1'b1;
		mul_a						=	4'hd;
		mul_b						=	4'h8;		
	end

	pipeline_mul inst_pipeline_mul (
		.clk(clk),
		.rst_n(rst_n),
		.mul_a(mul_a),
		.mul_b(mul_b),
		.mul_out(mul_out)
		);

endmodule