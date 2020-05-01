
`timescale 1ns/1ps

module tb_synch_fifo;
	
	reg					fifo_clk		;
	reg					rst_n			;
	reg 				fifo_wren		;
	reg		[7:0]		fifo_wrdata		;
	reg 				fifo_rden		;
	wire 	[7:0]		fifo_rddata		;
	wire 				fifo_full 		;
	wire 				fifo_empty 		;
	wire 	[4:0]		fifo_room_avail ;
	wire 	[4:0]		fifo_data_avail ;

	reg		[7:0]		mem	[15:0]		;
	synch_fifo inst_synch_fifo (
		.fifo_clk		 (fifo_clk		),
		.rst_n			 (rst_n			),
		.fifo_wren		 (fifo_wren		),
		.fifo_wrdata	 (fifo_wrdata	),
		.fifo_rden		 (fifo_rden		),
		.fifo_rddata	 (fifo_rddata	),
		.fifo_full 		 (fifo_full 	),
		.fifo_empty 	 (fifo_empty 	),
		.fifo_room_avail (fifo_room_avail),
		.fifo_data_avail (fifo_data_avail)
		);
	initial $readmemh("wrdata.txt", mem);
	initial begin
		fifo_clk            =  1'b1;
		rst_n               =  1'b0;
		fifo_wren           =  1'b0;
		fifo_wrdata         =  0;
		fifo_rden           =  1'b0;
		#200;
		rst_n               =  1'b1;
		#200;
		fifo_wren           =  1'b1;
		writeData();
		fifo_wren           =  1'b0;
		#200;
		fifo_rden           =  1'b1;
		#100;
		fifo_wren           =  1'b1;
		fifo_wrdata         =  8'hfd;
	end

	task writeData;
		begin : start//if a local param is defined, for should have a name
			integer i;
			for(i = 0; i < 16; i = i+1) begin : loop
				fifo_wrdata =  mem[i];
				#20;
			end	
		end
	endtask
	always #10 fifo_clk     <= ~fifo_clk;
endmodule