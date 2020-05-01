//******************************************************************\
//***https://www.cnblogs.com/liujinggang/p/9609739.html#4432464***
//******************************************************************/
module spi_module(
	clk,
	rst_n,
	tx_en,
	rx_en,
	data_in,
	data_out,
	tx_done,
	rx_done,
	miso,
	mosi,
	cs_n,
	sck
	);
	input							       clk;
	input							       rst_n;
	input							       tx_en;
	input							       rx_en;
	input							       miso;
	input				    [7:0]		 data_in;
	output		reg		[7:0]		 data_out;
	output		reg					     tx_done;
	output		reg					     rx_done;
	output		reg					     sck;
	output		reg					     cs_n;
	output		reg					     mosi;

	reg			       [3:0]		 tx_state, rx_state;
	localparam      S0          =   4'b0000;
	localparam      S1          =   4'b0001;
	localparam      S2          =   4'b0010;
	localparam      S3          =   4'b0011;
	localparam      S4          =   4'b0100;
	localparam      S5          =   4'b0101;
	localparam      S6          =   4'b0110;
	localparam      S7          =   4'b0111;
	localparam      S8          =   4'b1000;
	localparam      S9          =   4'b1001;
	localparam      S10         =   4'b1010;
	localparam      S11         =   4'b1011;
	localparam      S12         =   4'b1100;
	localparam      S13         =   4'b1101;
	localparam      S14         =   4'b1110;
	localparam      S15         =   4'b1111;

	always @(posedge clk or negedge rst_n)  begin
		if (!rst_n) begin
			tx_state            <=  S0;
			rx_state            <=  S0;
			data_out            <=  8'd0;
			tx_done             <=  1'b0;
			rx_done             <=  1'b0;
			sck                 <=  1'b0;
			cs_n                <=  1'b1;
			mosi                <=  1'b0;
		end
		else if (tx_en) begin
			tx_state            <=  S0;
			cs_n                <=  1'b0;
			case(tx_state)
				S1,S3,S5,S7,S9,S11,S13,S15: begin
					sck         <=  1'b1;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b0;
				end
				S0: begin
					mosi        <=  data_in[7];
					sck         <=  1'b0;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b0;
				end
				S2: begin
					mosi        <=  data_in[6];
					sck         <=  1'b0;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b0;
				end
				S4: begin
					mosi        <=  data_in[5];
					sck         <=  1'b0;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b0;
				end
				S6: begin
					mosi        <=  data_in[4];
					sck         <=  1'b0;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b0;
				end
				S8: begin
					mosi        <=  data_in[3];
					sck         <=  1'b0;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b0;
				end
				S10: begin
					mosi        <=  data_in[2];
					sck         <=  1'b0;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b0;
				end
				S12: begin
					mosi        <=  data_in[1];
					sck         <=  1'b0;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b0;
				end
				S14: begin
					mosi        <=  data_in[0];
					sck         <=  1'b0;
					tx_state    <=  tx_state    +   1'b1;
					tx_done     <=  1'b1;
				end	
			endcase
		end
		else if (rx_en) begin
			rx_state            <=  S0; 
			cs_n                <=  1'b0;
			case(rx_state)
				S0,S2,S4,S6,S8,S10,S12,S14: begin
					sck         <=  1'b0;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b0;
				end
				S1: begin
					data_out[7] <=  miso;
					sck         <=  1'b1;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b0;
				end
				S3: begin
					data_out[6] <=  miso;
					sck         <=  1'b1;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b0;
				end
				S5: begin
					data_out[5] <=  miso;
					sck         <=  1'b1;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b0;
				end
				S7: begin
					data_out[4] <=  miso;
					sck         <=  1'b1;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b0;
				end
				S9: begin
					data_out[3] <=  miso;
					sck         <=  1'b1;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b0;
				end
				S11: begin
					data_out[2] <=  miso;
					sck         <=  1'b1;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b0;
				end
				S13: begin
					data_out[1] <=  miso;
					sck         <=  1'b1;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b0;
				end
				S15: begin
					data_out[0] <=  miso;
					sck         <=  1'b1;
					rx_state    <=  rx_state    +   1'b1;
					rx_done     <=  1'b1;
				end
			endcase
		end
		else begin
			tx_state            <=  S0;
			rx_state            <=  S0;
			data_out            <=  8'd0;
			tx_done             <=  1'b0;
			rx_done             <=  1'b0;
			sck                 <=  1'b0;
			cs_n                <=  1'b1;
			mosi                <=  1'b0;
		end
	end
endmodule