// A full adder module 

module FullAdder(
	input a, b, c_in,
	output s, c_out 
);

// Aux wires for intermediate results
wire mid; 
// Aux wires for intermediate carries
wire mid_carry, mid_carry2;


// Create 2 instances of half adder
HalfAdder Adder1 (
	.a(a),
	.b(b),
	.s(mid),
	.c_out(mid_carry)
);

HalfAdder Adder2(
	.a(mid),
	.b(c_in),
	.s(s),
	.c_out(mid_carry2)
);

// Update carry with both intermediate carries
assign  c_out = mid_carry | mid_carry2;

endmodule 