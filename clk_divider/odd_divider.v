//*********************************************************\
//****************5分频电路，占空比50%*******************
//*********************************************************/
module odd_divider(
	clk_in					,
	rst_n					,
	clk_out_odd
	);
	
	input					clk_in;
	input					rst_n;
	output					clk_out_odd;

	localparam      N    =   5;
	localparam      HIGH =   1;
	localparam      LOW  =   (N-1) / 2 + HIGH;
	wire					pos_clk,neg_clk;
	reg			[2:0]		pos_cnt,neg_cnt;

	always @(posedge clk_in) begin
		if (!rst_n)
			pos_cnt      <=  0;
		else if (pos_cnt==N-1)
			pos_cnt      <=  0;
		else
			pos_cnt      <=  pos_cnt + 1'b1;
	end
	assign pos_clk       =   (pos_cnt==HIGH) ? 1'b1 : ((pos_cnt==LOW) ? 1'b0 : pos_clk);

	always @(negedge clk_in) begin
		if (!rst_n)
			neg_cnt      <=  0;
		else if (neg_cnt==N-1)
			neg_cnt      <=  0;
		else
			neg_cnt      <=  neg_cnt + 1'b1;
	end
	assign neg_clk       =   (neg_cnt==HIGH) ? 1'b1 : ((neg_cnt==LOW) ? 1'b0 : neg_clk);

	assign clk_out_odd   =  neg_clk | pos_clk;
endmodule