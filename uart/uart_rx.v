//*********************************************************\
//**************uart receiver***********************
//*********************************************************/
`define TEST_BAUD
module uart_rx(
	sclk,
	rst_n,
	rx,
	rx_data,
	po_flag
	);
	
	input						sclk;
	input						rst_n;
	input						rx;
	output	reg		[ 7:0]		rx_data;
	output	reg					po_flag;

//*********************************************************\
//******define internal signals and parameters*******
//*********************************************************/
	`ifndef TEST_BAUD
	localparam  BAUD_MAX =   5207;
	`else
	localparam  BAUD_MAX =   50;
	`endif
	localparam  BAUD_MID =   BAUD_MAX/2 - 1;
	localparam  BIT_MAX  =   8;
	reg							rx1,rx2,rx3;
	reg							rx_flag;
	reg							bit_flag;
	reg				[12:0]		baud_cnt;
	reg				[ 3:0]		bit_cnt;
	wire						neg_flag;

	//采集rx信号
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n) begin
			rx1          <=  1'b1;
			rx2          <=  1'b1;
			rx3          <=  1'b1;
		end
		else begin
			rx1          <=  rx;
			rx2          <=  rx1;
			rx3          <=  rx2;
		end
	end
	//检验下降沿
	assign neg_flag      =  ~rx2 & rx3;
	//rx_flag
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			rx_flag      <=  1'b0;
		else if (neg_flag)
			rx_flag      <=  1'b1;
		else if (baud_cnt==BAUD_MAX && bit_cnt==0)
			rx_flag      <=  1'b0;
	end
	//baud_cnt
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			baud_cnt     <=  0;
		else if (rx_flag && baud_cnt==BAUD_MAX)
			baud_cnt     <=  0;
		else if (rx_flag)
			baud_cnt     <=  baud_cnt    +   1'b1;
		else
			baud_cnt     <=  0;
	end
	//bit_flag
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			bit_flag     <=  1'b0;
		else if(baud_cnt==BAUD_MID)
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
			bit_cnt      <=  bit_cnt     +   1'b1;
	end
	//rx_data
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			rx_data      <=  8'b0;
		else if (bit_flag)
			rx_data      <=  {rx2, rx_data[7:1]};
	end
	//po_flag
	always @(posedge sclk or negedge rst_n)  begin
		if (!rst_n)
			po_flag      <=  1'b0;
		else if (bit_cnt==BIT_MAX && bit_flag)
			po_flag      <=  1'b1;
		else
			po_flag      <=  1'b0;
	end

endmodule