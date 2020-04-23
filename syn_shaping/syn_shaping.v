//*********************************************************\
//****************同步整形电路************************
//*********************************************************/
module syn_shaping(
	clk						,
	rst_n					,
	din						,
	dout					
	);
	
	input						clk;
	input						rst_n;
	input						din;
	output						dout;

	reg							din_r_1;
	reg							din_r_2;

	always @(posedge clk) begin
		if (!rst_n) begin
			din_r_1			<=	1'b0;
			din_r_2			<=	1'b0;
		end
		else begin
			din_r_1 		<=	din;
			din_r_2			<=	din_r_1;
		end
	end
	
	assign 		dout		=	din_r_1 & (~din_r_2);
endmodule