// A pro module for a comparator

module Comparator(
	input signed [31:0] num1, num2,
	output reg [3:0] status_flag
);

// Flag indexes 
parameter NEGATIVE = 0,
			 ZERO = 1,
			 CARRY = 2,
			 OVERFLOW = 3;
			 

// Auxiliar for getting result of subtractor
wire signed [31:0] sub_result;

// Substractor module
Subtractor SUB(
	.num1(num1),
	.num2(num2),
	.result(sub_result)
);

// Update flags when result has changed
always @(sub_result)
begin
	// Zero 
	status_flag[ZERO] <= (sub_result == 0);
	// Sign
	status_flag[NEGATIVE] <= (sub_result[31]);  // MSB of result is the sign
	// Overflow detection
	status_flag[OVERFLOW] <= (num1[31] && !num2[31] && !sub_result[31]) ||  (!num1[31] && num2[31] && sub_result[31]);  // Occurs when subtraction signs dont make any sense 
	// positive - negative = negative or negative - positive = positive mean overflow occurred
end

endmodule 