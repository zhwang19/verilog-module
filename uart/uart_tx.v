 //*********************************************************\
 //*****************uart transmit*************************
 //*********************************************************/
 `define TEST_BAUD
 module uart_tx(
 	sclk,
 	rst_n,
 	tx_trig,
 	tx_data,
 	tx
 	);
 
 	input					sclk;
 	input					rst_n;
 	input					tx_trig;
 	input		[ 7:0]		tx_data;
 	output	reg				tx;

//*********************************************************\
//******define internal signals and parameters*******
//*********************************************************/
	`ifndef TEST_BAUD
	localparam  BAUD_MAX =   5207;
	`else
	localparam  BAUD_MAX =   50;
	`endif
	localparam  BIT_MAX  =   8;
	reg			[ 7:0]		tx_data_r;
	reg						tx_flag;
	reg			[12:0]		baud_cnt;
	reg			[ 3:0]		bit_cnt;
	reg						bit_flag;

	//tx_data_r
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			tx_data_r    <=  0;
		else if (tx_trig && !tx_flag)
			tx_data_r    <=  tx_data;
	end
	
	//tx_flag
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			tx_flag      <=  1'b0;
		else if (tx_trig)
			tx_flag      <=  1'b1;
		else if (bit_flag && bit_cnt==BIT_MAX)
			tx_flag      <=  1'b0;
	end
	//baud_cnt
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			baud_cnt     <=  0;
		else if (tx_flag && baud_cnt==BAUD_MAX)
			baud_cnt     <=  0;
		else if (tx_flag)
			baud_cnt     <=  baud_cnt    +   1'b1;
		else
			baud_cnt     <=  0;
	end
	//bit_flag
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			bit_flag     <=  0;
		else if (baud_cnt==BAUD_MAX)
			bit_flag     <=  1'b1;
		else
			bit_flag     <=  1'b0;
	end
	//bit_cnt
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			bit_cnt      <=  0;
		else if (bit_flag && bit_cnt==BIT_MAX)
			bit_cnt      <=  0;
		else if (bit_flag)
			bit_cnt      <=  bit_cnt +   1'b1;
	end
	//tx
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			tx           <=  1'b1;
		else if (tx_flag) begin //此处必须要有这个条件
			tx           <=  1'b1;
			case(bit_cnt)
				0:  tx   <=  1'b0;
				1:  tx   <=  tx_data_r[0];
				2:  tx   <=  tx_data_r[1];
				3:  tx   <=  tx_data_r[2];
				4:  tx   <=  tx_data_r[3];
				5:  tx   <=  tx_data_r[4];
				6:  tx   <=  tx_data_r[5];
				7:  tx   <=  tx_data_r[6];
				8:  tx   <=  tx_data_r[7];
			endcase
		end
		else
			tx           <=  1'b1;
	end

/*	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			tx           <=  1'b1;
		else begin 如果没有tx_flag==1这个条件，那么由于bit_cnt默认为 0，tx的默认值会变为0，这样是和uart空闲时数据位为高电平时冲突的
			tx           <=  1'b1;
			case(bit_cnt)
				0:  tx   <=  1'b0;
				1:  tx   <=  tx_data_r[0];
				2:  tx   <=  tx_data_r[1];
				3:  tx   <=  tx_data_r[2];
				4:  tx   <=  tx_data_r[3];
				5:  tx   <=  tx_data_r[4];
				6:  tx   <=  tx_data_r[5];
				7:  tx   <=  tx_data_r[6];
				8:  tx   <=  tx_data_r[7];
			endcase
		end
	end*/
	
 endmodule