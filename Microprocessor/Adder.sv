// A pro 32-bit full adder based adder module 

module Adder(
	input c_in,
	input [31:0] num1, num2,
	output [31:0] sum, 
	output c_out
);

// Auxiliary variables for full adders
wire [31:0] mid_carry;

// Create 32 instances of full adders
genvar i;
generate
    for(i = 0; i < 32; i = i + 1) begin: full_adder_gen
        FullAdder FullAdders(
            .a(num1[i]),
            .b(num2[i]),
            .c_in(i == 0 ? c_in : mid_carry[i - 1]),  // If i=0 the carry is considered as 1 because you need to add 1 to the complement to get two's complement of the number 
            .s(sum[i]),
            .c_out(mid_carry[i])
        );
    end
endgenerate 

// Get the final carry out 
assign c_out = mid_carry[31];

endmodule 