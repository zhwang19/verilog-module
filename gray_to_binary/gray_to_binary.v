//*********************************************************\
//*********************************************************
//*********************************************************/
module gray_to_binary # (
	parameter   PTR            =   8
	)
						(
	gray_value,
	binary_value
	);
input	[PTR-1:0]		gray_value;
output	[PTR-1:0]		binary_value;
//**********************************************************
wire	[PTR-1:0]		binary_value;

assign binary_value[PTR-1]     = gray_value[PTR-1];
generate
	genvar i;
	for (i = 0; i < PTR-1; i = i + 1)
	begin:identifier
		assign binary_value[i] =   binary_value[i+1]   ^   gray_value[i];
	end
endgenerate
endmodule