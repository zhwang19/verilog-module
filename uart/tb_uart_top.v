
`timescale 1ns/1ps

module tb_uart_top;
	
	reg 			sclk;
	reg				rst_n;
	reg 			tx_trig;
	reg 	[ 7:0]	tx_data;
	wire 	[ 7:0]	rx_data;
	wire			po_flag;

	//reg		[ 7:0]	mem	[1:0];

	initial sclk    = 0;
	always #10 sclk = ~sclk;

	//initial $readmemeh("tx_data.txt", mem);
	initial begin
		rst_n       <= 	1'b0;
		tx_trig		<= 	1'b0;
		tx_data		<= 	0;
		#200;
		rst_n       <= 	1'b1;
		#200;
		tx_data		<= 	8'h4e;
		#200;
		tx_trig		<=	1'b1;
		#20;
		tx_trig		<=	1'b0;
		#20000;// > 50*20*10 = 10000
		tx_data		<= 	8'h37;
		#200;
		tx_trig		<=	1'b1;
		#20;
		tx_trig		<=	1'b0;
		#20000;// > 50*20*10 = 10000
		tx_data		<= 	8'hfa;
		#200;
		tx_trig		<=	1'b1;
		#20;
		tx_trig		<=	1'b0;
		#20000;// > 50*20*10 = 10000	
	end

/*	task tx_byte ();
		integer i;
		for(i = 0; i < 4; i = i+1) begin
			tx_data <=  mem[i];
			#200
			tx_trig <=	1'b1;
			#20
			tx_trig <=  1'b0;
			#5000;
		end
	endtask*/
	uart_top inst_uart_top (
		.sclk(sclk),
		.rst_n(rst_n),
		.tx_trig(tx_trig),
		.tx_data(tx_data),
		.rx_data(rx_data),
		.po_flag(po_flag)
		);

endmodule