//******************************************************************\
//*************************4λ��ˮ�߳˷���**************************
//*****�봮�г˷���ԭ������ͬ��ֻ����������һ������λ���һ��**********
//*****����ˮ�����ڵ�һ�����ھͰ����е���λ�������ˣ�Ȼ���������*******
//******************************************************************/
module pipeline_mul(
	clk								,
	rst_n							,
	mul_a							,
	mul_b							,
	mul_out					
	);
	localparam                      MUL_WIDTH =   4;
	localparam                      RES_WIDTH =   8;

	input								clk;
	input								rst_n;
	input			[MUL_WIDTH-1:0]		mul_a;
	input			[MUL_WIDTH-1:0]		mul_b;
	output			[RES_WIDTH-1:0]		mul_out;
	reg				[RES_WIDTH-1:0]		mul_out;

	reg				[RES_WIDTH-1:0]		store1;
	reg				[RES_WIDTH-1:0]		store2;
	reg				[RES_WIDTH-1:0]		store3;
	reg				[RES_WIDTH-1:0]		store4;
	reg				[RES_WIDTH-1:0]		add12;
	reg				[RES_WIDTH-1:0]		add34;

	always @(posedge clk or negedge rst_n)  begin
		if (!rst_n) begin
			mul_out                           <=  8'd0;
			store1                            <=  8'd0;
			store2                            <=  8'd0;
			store3                            <=  8'd0;
			store4                            <=  8'd0;
			add12                             <=  8'd0;
			add34                             <=  8'd0;

		end
		else begin //��λ���
			store1                            <=  mul_b[0] ? {4'b0, mul_a} : 8'd0;
			store2                            <=  mul_b[1] ? {3'b0, mul_a, 1'b0} : 8'd0;
			store3                            <=  mul_b[2] ? {2'b0, mul_a, 2'b0} : 8'd0;
			store4                            <=  mul_b[3] ? {1'b0, mul_a, 3'b0} : 8'd0;
			add12                             <=  store1    +   store2;
			add34                             <=  store3    +   store4;
			mul_out                           <=  add12     +   add34;
		end
	end
	
endmodule