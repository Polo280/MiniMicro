module BitwiseNot(
	input wire [31:0] in,
	output wire [31:0] out 
);

genvar i;
generate
	for (i = 0; i < 32; i = i + 1) begin : mvns_gen
    assign out[i] = ~in[i];
	 end
endgenerate 

endmodule 

