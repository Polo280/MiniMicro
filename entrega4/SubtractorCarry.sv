// 32-bit subtractor with carry
module SubtractorCarry(
	 input c_in,
    input signed [31:0] num1, num2,
    output signed [31:0] result,
    output c_out   // carry out
);

// Complement of number 2 (one's complement)
wire [31:0] complement;
assign complement = ~num2;

// Auxiliary variables for full adders
wire [31:0] mid_carry;

// Create 32 instances of full adders
genvar i;
generate
    for(i = 0; i < 32; i = i + 1) begin: full_adder_carry
        FullAdder FullAdd(
            .a(num1[i]),
            .b(complement[i]),
            .c_in(i == 0? c_in : mid_carry[i - 1]),  // If its the first full adder, consider the carry input
            .s(result[i]),
            .c_out(mid_carry[i])
        );
    end
endgenerate

// The final carry out is the last item of mid_carry
assign c_out = mid_carry[31];

endmodule
