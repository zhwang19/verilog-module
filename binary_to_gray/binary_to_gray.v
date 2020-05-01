//*********************************************************\
//*********************************************************
//*********************************************************/
module binary_to_gray # (
	parameter   PTR      =   8
	)
						(
	binary_value	,
	gray_value		
	);
input		[PTR-1:0]	binary_value;
output		[PTR-1:0]	gray_value;

//*********************************************************
wire		[PTR-1:0]	gray_value;

assign gray_value[PTR-1] =   binary_value[PTR-1];
generate
	genvar i;
	for (i = 0; i < PTR-1; i = i + 1)
	begin:identifier
		assign gray_value[i]    =   binary_value[i]	^ binary_value[i+1];
	end
endgenerate
endmodule