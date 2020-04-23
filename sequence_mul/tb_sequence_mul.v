
`timescale 1ns/1ps

module tb_sequence_mul;
	
	reg 						clk;
	reg 						en;
	reg 		[ 7:0]			a;
	reg 		[ 7:0]			b;
	wire 		[15:0]			z;
	wire						z_flag;

	initial clk    = 0;
	always #10 clk = ~clk;

	initial begin
		en         <=      1'b0;
		#200
		en         <=      1'b1;
		a          <=      8'haf;
		b          <=      8'h34;
		#300
		en         <=      1'b0;
		#200
		en         <=      1'b1;
		a          <=      8'h5e;
		b          <=      8'h4c;
	end

	sequence_mul inst_sequence_mul (
		.clk(clk),
		.en(en),
		.a(a),
		.b(b),
		.z(z),
		.z_flag(z_flag)
		);

endmodule