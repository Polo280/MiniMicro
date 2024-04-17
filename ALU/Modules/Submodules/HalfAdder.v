// A half adder pro module 

module HalfAdder(
	input a, b,
	output s, c_out 
);

// The result is an XOR of both bits
assign s = a ^ b;
// The carry is an AND of both bits
assign c_out = a & b;

endmodule 