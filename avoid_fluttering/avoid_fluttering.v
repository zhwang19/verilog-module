//*********************************************************\
//****************按键防抖动电路**********************
//*********************************************************/
module avoid_fluttering(
	clk						,//100MHz
	rst_n					,
	key_in					,
	key_out					
	);
	input							clk;
	input							rst_n;
	input							key_in;
	output							key_out;

//*********************************************************\
//*******define parameters and internal signals************
//*********************************************************/
	localparam  S0        =   0;
	localparam  S1        =   1;
	localparam  S2        =   2;
	localparam  S3        =   3;
	localparam  CNT_MAX   =   1_999_999;
	reg         [ 1:0]				state;
	reg			[20:0]				cnt;
	reg								key_in_reg;
	wire							pos_key;
	wire							neg_key;

/**detch key edge**/
always @(posedge clk or negedge rst_n)  begin
	if (!rst_n)
		key_in_reg        <=  1'b1;
	else
		key_in_reg        <=  key_in;
end
assign     neg_key        =   ~key_in & key_in_reg;
assign     pos_key        =   key_in  & ~key_in_reg;

/**state transfer**/
always @(posedge clk or negedge rst_n)  begin
	if (!rst_n) begin
		state             <=  S0;
	end
	else begin
		case(state)
			S0: begin
				if (neg_key)
					state <=  S1;
				else
					state <=  S0;
			end
			S1: begin
				if (cnt==CNT_MAX) 
					state <=  S2;
				else
					state <=  S1;
			end
			S2: begin
				if(pos_key)
					state <=  S3;
				else
					state <=  S2;
			end
			S3: begin
				if (cnt==CNT_MAX)
					state <=  S1;
				else
					state <=  S3;
			end
		endcase
	end
end
//cnt
always @(posedge clk or negedge rst_n)  begin
	if (!rst_n || neg_key || pos_key)
		cnt               <=  21'd0;
	else if (cnt < CNT_MAX)
		cnt               <=  cnt + 1'b1;         
end

assign  key_out           =   (state==S0) ? 1'b1 : ((state==S3) ? 1'b0 : key_out);
endmodule