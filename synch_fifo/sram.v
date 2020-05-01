//*********************************************************\
//sram
//width:8
//depth:16
//*********************************************************/
module sram	#(
	parameter   PTR   =   4,
				WIDTH =   8,
				DEPTH =   16
	)
			(
	wrclk	,
	wren	,
	wrptr	,
	wrdata	,
	rdclk	,
	rden	,
	rdptr	,
	rddata	
	);

input						wrclk;
input						wren;
input	[PTR-1:0]			wrptr;
input	[WIDTH-1:0]			wrdata;
input						rdclk;
input						rden;
input	[PTR-1:0]			rdptr;
output	[WIDTH-1:0]			rddata;
//define internal signals and parameters, define ports
reg		[WIDTH-1:0]			rddata;
reg		[WIDTH-1:0]			fifo	[DEPTH-1:0];

//write data
always @(posedge wrclk) begin
	if (wren)
		fifo[wrptr]   <=  wrdata;
end
//read data
always @(posedge rdclk) begin
	if (rden)
		rddata        <=  fifo[rdptr];
end

endmodule