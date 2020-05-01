
`timescale 1ns/1ps

module tb_spi_module;
	
	reg 			clk			;
	reg 			rst_n		;
	reg 			tx_en 		;
	reg 			rx_en 		;
	reg 	[7:0]	data_in		;
	reg 			miso 		;
	wire 			tx_done		;
	wire 			rx_done		;
	wire 	[7:0]	data_out	;
	wire 			mosi 		;
	wire 			cs_n 		;
	wire 			sck			;

	initial begin
		clk         =   1'b0;
		rst_n       =   1'b0;
		tx_en       =   1'b0;
		rx_en       =   1'b0;
		data_in     =   8'd0;
		miso        =   1'b0;
		#200;
		rst_n       =   1'b1;
		#200;
		tx_en       =   1'b1;
	end
	always #10 clk  = ~clk;

	always @(posedge clk or negedge rst_n)  begin
		if (!rst_n)
			data_in <=  8'd0;
		else if (data_in==8'hff)
			tx_en   <=  1'b0;
		else if (tx_done)
			data_in <=  data_in +   1'b1;
	end
	
	spi_module inst_spi_module (
		.clk		(clk		),	
		.rst_n		(rst_n		),	
		.tx_en 		(tx_en 		),	
		.rx_en 		(rx_en 		),	
		.data_in	(data_in	),	
		.miso 		(miso 		),	
		.tx_done	(tx_done	),	
		.rx_done	(rx_done	),	
		.data_out	(data_out	),	
		.mosi 		(mosi 		),	
		.cs_n 		(cs_n 		),	
		.sck		(sck		)	
		);

endmodule