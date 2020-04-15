//*********************************************************\
//*******************16分频电路**********************
//*********************************************************/
module even_divider(
	clk_in				,
	rst_n				,
	clk_out_even
	);

	input						clk_in;
	input 						rst_n;
	output						clk_out_even;

	localparam  N       =       16;
	localparam  M       =       N / 2 - 1;

	reg			[2:0]			cnt;

/*	always @(posedge clk_in) begin
		if (!rst_n)
			cnt         <=      0;
		else if (cnt==M)
			cnt         <=      0;
		else
			cnt         <=      cnt + 1'b1;
	end
	assign clk_out_even = (cnt==M) ? ~clk_out_even : clk_out_even;
*/
	reg							clk_out_even_nxt;

	always @(posedge clk_in) begin
		if (!rst_n)
			cnt			<=		0;
		else if (cnt==M)
			cnt			<=		0;
		else
			cnt			<=		cnt + 1'b1;
	end
	always @(posedge clk_in) begin
		if (!rst_n)
			clk_out_even_nxt	<=	1'b0;
		else if (cnt==M)
			clk_out_even_nxt 	<=	~clk_out_even;
	end
	assign clk_out_even  		= 	clk_out_even_nxt;
endmodule