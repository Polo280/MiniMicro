// A module to execute bitwise exclusive OR 

module EORS(
	clk,
	num1, 
	num2, 
	result
);

input clk;
input [31:0] num1, num2;
output [31:0] result;

// Generate hardware 
genvar i;
generate
	for(i = 0; i < 32; i = i + 1) begin: eors_gen
		assign result[i] = num1[i] ^ num2[i];
	end
endgenerate

endmodule

