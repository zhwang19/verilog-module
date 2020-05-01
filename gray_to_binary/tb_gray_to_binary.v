
`timescale 1ns/1ps

module tb_gray_to_binary;
	
	reg					clk			;
	reg					rst_n		;
	reg		[7:0]		gray_value	;
	wire	[7:0]		binary_value;

	gray_to_binary inst_gray_to_binary (
		.gray_value		(gray_value		),
		.binary_value	(binary_value	)
		);
	integer i;//must be decleared out of the initial block
	initial begin : init
		clk            =   1'b0;
		rst_n          =   1'b0;
		#200;
		rst_n          =   1'b1;
		gray_value     =   8'h0;
		#20;
		for (i = 0; i < 255; i = i+1) begin
			@(posedge clk);
			gray_value =   gray_value  +   1'b1;
		end
	end
	always #10 clk     = ~clk;

endmodule