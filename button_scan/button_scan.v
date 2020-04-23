//*********************************************************\
//*****************按键扫描电路**********************
//*********************************************************/
module button_scan(
	clk					,
	in_s				,
	out_s				,
	num					
	);	
	
	input							clk;
	input		[ 3:0]				ins_s;
	output		[ 3:0]				out_s;
	output		[ 4:0]				num;
	reg			[ 4:0]				num;

	reg         [ 1:0]              cnt    =   0;
	reg         [ 1:0]              tmp    =   0;
	reg         [ 3:0]              out_st =   0;
	wire		[ 7:0]				dsample;

	//将扫描输出和输入信号级联，得到矩阵扫描结果
	assign dsample                         =   {out_st,in_s};
	assign out_s                           =   out_st;

	always @(posedge clk) begin
		cnt                                <=  cnt + 1'b1;
		case(cnt)
			2'b00:out_st                   <=  4'b1000;
			2'b01:out_st                   <=  4'b0100;
			2'b10:out_st                   <=  4'b0010;
			2'b11:out_st                   <=  4'b0001;
		endcase
	end
	always @(posedge clk) begin
		if(in_s==4'b0000) begin
			if(tmp==3) begin
				num                        <= 16;
				tmp                        <= 0;
			end
			else begin
				num                        <= num;
				tmp                        <= tmp + 1;
			end
		end
		else begin
			tmp                            <= 0;
			case(dsample)
				8'b1000_0001:num           <=  0;
				8'b1000_0010:num           <=  1;
				8'b1000_0100:num           <=  2;
				8'b1000_1000:num           <=  3;
				8'b0100_0001:num           <=  4;
				8'b0100_0010:num           <=  5;
				8'b0100_0100:num           <=  6;
				8'b0100_1000:num           <=  7;
				8'b0010_0001:num           <=  8;
				8'b0010_0010:num           <=  9;
				8'b0010_0100:num           <= 10;
				8'b0010_1000:num           <= 11;
				8'b0001_0001:num           <= 12;
				8'b0001_0010:num           <= 13;
				8'b0001_0100:num           <= 14;
				8'b0001_1000:num           <= 15;
			endcase
		end
	end
	
endmodule