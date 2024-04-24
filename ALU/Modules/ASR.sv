// Arithmetic right shifting module (extends the sign after shifting)

module ASR(
	input signed[31:0] num,
	input [4:0] shifts,
	output reg [31:0] shifted,
	output wire c_out
);

// Carry (check if shifts is at least 1
assign c_out = (shifts > 0)? num[0] : 0;

// Do the shifting
integer i; 
always @(*) 
begin 
	for(i=0; i < 32; i = i + 1) begin
		if(i > shifts + 1)
			shifted[i] = num[31];
		else
			shifted[i] = num[i + shifts];
	end
end 

endmodule 