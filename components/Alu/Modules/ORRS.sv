module ORRS (
 clk,
 num1,
 num2,
 result
 //flags
 );

input clk;
input [31:0] num1 , num2;
output[31:0] result;
//output reg [0:3] flags ; // N, Z, C, V

genvar i;
generate
	for (i = 0; i < 32; i = i + 1) begin : orrs_gen
    assign result[i] = num1[i] | num2[i];
	 end
endgenerate 

// Update flags
//flags [0] = result [31]; // N
//flags [1] <= (&(~ result)) ? 1’b1 : 1’b0; // Z

endmodule 