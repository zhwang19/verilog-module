
`timescale 1ns/1ps

module tb_tb_binary_to_gray;
	
	reg					clk			;
	reg					rst_n		;
	reg		[7:0]		binary_value;	
	wire	[7:0]		gray_value	;		

	binary_to_gray inst_binary_to_gray (
		.binary_value	(binary_value	),
		.gray_value		(gray_value		)
		);

	initial begin
		clk              =   1'b0;
		rst_n            =   1'b0;
		#200
		rst_n            =   1'b1;
		binary_value     =   8'h0;
		#20;
		selfAdd();
	end
	always #10 clk       = ~clk;

	task selfAdd();
		integer i;
		for (i = 0; i <255; i = i+1) begin : loop
			binary_value =   binary_value + 1'b1;
			#20;
		end
	endtask
endmodule