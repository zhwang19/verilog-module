//*********************************************************\
//****************8位串行乘法器*****
//*********************************************************/
module sequence_mul(
	clk						,
	en 						,
	a 						,
	b 						,
	z						,
	z_flag					
	);

	input							clk;
	input							en;							
	input		[ 7:0]				a;							//被乘数
	input		[ 7:0]				b;							//乘数
	output		[15:0]				z;
	output							z_flag;						//得出结果后拉高

	localparam      IDLE              =   0;
	localparam      S1                =   1;
	localparam      S2                =   2;
	localparam      S3                =   3;
	reg			[ 7:0]				b_shr;						//乘数的移位寄存器
	reg 		[15:0]				a_shl;						//每次累加都需要先将被乘数左移一位
	reg 		[15:0]				z_out;						
	reg         [ 2:0]              state;
	reg  		[ 3:0]				cnt;						//累加次数，一共要累加8次
	
	always @(posedge clk) begin
		if (!en)
			state                     <=  IDLE;
		else begin
			case(state)
				IDLE:
					state             <=  S1;
				S1: begin
						state         <=  S2;
						a_shl         <=  {{8{a[7]}}, a};       //注意高8位要补a的符号位
						z_out         <=  0;
						cnt           <=  0;
						b_shr         <=  b;
					end
				S2: begin
						if (cnt==7)
							state     <=  S3;
						else begin
							if (b_shr[0])
								z_out <=  z_out + a_shl;        //如果b_shr最低位是1，此次累加需要加上移位后的被乘数
							b_shr     <=  b_shr>>1;
							a_shl     <=  a_shl<<1;
							cnt       <=  cnt +   1'b1;
						end
					end
				S3:
					state             <=  S1;
			endcase
		end
	end
	
	assign z                          = (state==S3)? z_out : 0;
	assign z_flag                     = (state==S3) ? 1'b1 : 1'b0;
endmodule