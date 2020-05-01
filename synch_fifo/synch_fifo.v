//*********************************************************\
//synch ffio
//width	8
//depth	16
//*********************************************************/
module synch_fifo #(
	parameter   FIFO_PTR       =   4,
				FIFO_WIDTH     =   8,
				FIFO_DEPTH    =   16
	)
					(
	fifo_clk		,
	rst_n			,
	fifo_wren		,
	fifo_wrdata		,
	fifo_rden		,
	fifo_rddata		,
	fifo_full 		,
	fifo_empty 		,
	fifo_room_avail ,
	fifo_data_avail 
	);
//**********************************************************
input						fifo_clk;
input						rst_n;
input						fifo_wren;
input	[FIFO_WIDTH-1:0]	fifo_wrdata;
input						fifo_rden;
output	[FIFO_WIDTH-1:0]	fifo_rddata;
output						fifo_full;
output						fifo_empty;
output	[FIFO_PTR:0]		fifo_room_avail;
output	[FIFO_PTR:0]		fifo_data_avail;

//localparam and internal signals
//**********************************************************
localparam    FIFO_DEPTH_MINUS =   FIFO_DEPTH -   1;
reg		[FIFO_PTR-1:0]		wr_ptr,wr_ptr_nxt;
reg		[FIFO_PTR-1:0]		rd_ptr,rd_ptr_nxt;
reg		[FIFO_PTR:0]		num_entries,num_entries_nxt;//record the number of data,which is not read yet
reg							fifo_full,fifo_empty;
wire						fifo_full_nxt,fifo_empty_nxt;

//write-pointer control logic 
//**********************************************************
always @(*) begin
	wr_ptr_nxt                 =   wr_ptr;
	if (fifo_wren) begin
		if (wr_ptr==FIFO_DEPTH_MINUS)
			wr_ptr_nxt         =   1'd0;
		else
			wr_ptr_nxt         =   wr_ptr  +   1'b1;
	end
end
//read-pointer control logic
//**********************************************************
always @(*) begin
	rd_ptr_nxt                 =   rd_ptr;
	if (fifo_rden) begin
		if (rd_ptr==FIFO_DEPTH_MINUS)
			rd_ptr_nxt         =   1'd0;
		else
			rd_ptr_nxt         =   rd_ptr  +   1'b1;
	end
end
//caculate number of occupied entries in the fifo
//***********************************************************
always @(*) begin
	num_entries_nxt            =   num_entries;
	if (fifo_wren && fifo_rden)
		num_entries_nxt        =   num_entries;
	else if (fifo_wren)
		num_entries_nxt        =   num_entries     +   1'b1;
	else if (fifo_rden)
		num_entries_nxt        =   num_entries     -   1'b1;
end

assign fifo_full_nxt           =   (num_entries_nxt==FIFO_DEPTH);
assign fifo_empty_nxt          =   (num_entries_nxt==0);
assign fifo_data_avail         =   (num_entries);
assign fifo_room_avail         =   (FIFO_DEPTH-num_entries);

//***********************************************************
always @(posedge fifo_clk or negedge rst_n)  begin
	if (!rst_n) begin
		wr_ptr                 <=   1'd0;
		rd_ptr                 <=   1'd0;
		num_entries            <=   1'd0;
		fifo_full              <=   1'd0;
		fifo_empty             <=   1'd0;
	end
	else begin
		wr_ptr                 <=   wr_ptr_nxt;
		rd_ptr                 <=   rd_ptr_nxt;
		num_entries            <=   num_entries_nxt;
		fifo_full              <=   fifo_full_nxt;
		fifo_empty             <=   fifo_empty_nxt;
	end
end

//instant the sram module
//***********************************************************
sram 	#(
	.PTR 	(FIFO_PTR 	)	,
	.WIDTH 	(FIFO_WIDTH )	,
	.DEPTH 	(FIFO_DEPTH )	
	) ins_sram (
	.wrclk	(fifo_clk	)	,
	.wren	(fifo_wren	)	,
	.wrptr	(wr_ptr 	)	,
	.wrdata	(fifo_wrdata)	,
	.rdclk	(fifo_clk	)	,
	.rden	(fifo_rden	)	,
	.rdptr	(rd_ptr 	)	,
	.rddata	(fifo_rddata)	
	);
endmodule
















