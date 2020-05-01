//*********************************************************\
//**************uart top module*****************
//*********************************************************/
module uart_top(
	sclk,
	rst_n,
	tx_trig,
	tx_data,
	rx_data,
	po_flag
	);
	
	input				sclk;
	input				rst_n;
	input				tx_trig;
	input	[ 7:0]		tx_data;
	output	[ 7:0]		rx_data;
	output				po_flag;
	wire				tx,rx;

	uart_tx ins_uart_tx (
		.sclk(sclk),
		.rst_n(rst_n),
		.tx_trig(tx_trig),
		.tx_data(tx_data),
		.tx(tx)
		);
	assign 	rx 	= 	tx;
	uart_rx ins_uart_rx (
		.sclk(sclk),
		.rst_n(rst_n),
		.rx(rx),
		.rx_data(rx_data),
		.po_flag(po_flag)
		);

endmodule