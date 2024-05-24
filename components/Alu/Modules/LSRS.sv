// Logic Right Shift module 

module LSRS(
	input [31:0] num,
	input [4:0] shifts,
	output reg [31:0] shifted,
	output wire c_out
);

// Carry out 
assign c_out = (shifts > 0)? num[0] : 0;

// Do the shifting 
integer i;
always @(*)
begin
	for(i = 0; i < 32; i = i+1) begin
		if(i > 31 - shifts)
			shifted[i] = 0;
		else
			shifted[i] = num[i + shifts];
	end 
end 

endmodule 