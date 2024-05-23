// Bitwise AND module 

module ANDS (
 clk ,
 num1 ,
 num2 ,
 result
 );

 input clk;
 input [0:31] num1 , num2;
 output [0:31] result;
 //output reg [0:3] flags ; // N, Z, C, V

// Generate hardware for combinational logic
genvar i;
generate
	for (i = 0; i < 32; i = i + 1) begin : ands_gen
    assign result[i] = num1[i] & num2[i];
	 end
endgenerate 

 endmodule 