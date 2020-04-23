//*********************************************************\
//******************实现8.66分频**********************
//*********************************************************/
module clk_float_divider(
	clk_in						,
	rst_n						,
	clk_out							
	);
	
	input						clk_in;
	input						rst_n;
	output						clk_out;

	reg			[15:0]			cnt;//最大计数65535

	localparam  CNT_MAX =   65536;
	localparam  STEP    =   7568;   //65536/8.66 = 7568四舍五入

	always @(posedge clk_in) begin
		if (!rst_n)
			cnt         <=  0;
		else
			cnt         <=  cnt + STEP;
	end
	
	assign clk_out  = cnt[15];
endmodule