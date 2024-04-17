module ALU(
	input clk,
	input [4:0] instruction,
	input [31:0] num1, num2,
	output reg [31:0] result,
	output reg [3:0] flags    // N, Z, C, V
);

// Enable wires 
wire[20:0] enable;

////////////////// INSTRUCTION SET //////////////////

parameter // Logic operations
			 ANDS  = 1,			// Bitwise AND
			 ORRS  = 2,			// Bitwise OR 
			 MVNS  = 3,			// Bitwise NOT
			 EORS  = 4,		   // Bitwise XOR 
			 NAND  = 5,			// Bitwise NAND (NOT INCLUDED IN ARM INST SET)
			 
			 // Arithmetic operations 
			 ADCS  = 6,			// Add with carry
			 ADDS	 = 7,			// Normal addition
			 SBCS  = 8,			// Subtraction with carry
			 SUB   = 9,			// Subtraction
		    MULS  = 10,      // Multiplication

			 // Shifts
			 LSRS  = 11,		// Logic Shift Right 
			 LSLS  = 12,		// Logic Shift Left 
			 
			 // Rotates 
			 ROR   = 13,     	// Rotate right 
			 
			 // Extends
			 UXTB  = 14,  		// Unsigned extend byte 
			 UXTH  = 15,		// Unsigned extend halfword 
			 SXTB  = 16,		// Signed extend byte 
			 SXTH  = 17,		// Signed extend halfword 
			 
			 // Other instructions 
			 CMP   = 18,	   // Compare 
			 NOP   = 19;		// NO operation
			 
/////////////////////// FLAGS ///////////////////////
parameter NEGATIVE = 0,
			 ZERO = 1,
			 CARRY = 2,
			 OVERFLOW = 3;
			 
////////////////////// MODULES //////////////////////

///// ANDS /////
wire[31:0] ands_result;

ANDS ANDSModule(
 .clk(clk),
 .num1(num1),
 .num2(num2),
 .result(ands_result)
);

///// ORRS /////
wire[31:0] orrs_result;

ORRS ORRSModule(
 .clk(clk),
 .num1(num1),
 .num2(num2),
 .result(orrs_result)
);

///// MVNS /////
wire [31:0] mvns_result;

BitwiseNot MVNSModule(
	.in(num1),
	.out(mvns_result)
);

///// EORS /////
wire [31:0] eors_result;

EORS EORSModule(
	.clk(clk),
	.num1(num1),
	.num2(num2),
	.result(eors_result)
);

///// Adder /////
reg cin_adder;
wire cout_adder;
wire [31:0] adder_sum;

Adder MainAdder(
	.c_in(carry_adder),
	.num1(num1),
	.num2(num2),
	.sum(adder_sum),
	.c_out(cout_adder)
);


////////////////////// MAIN ALU LOGIC //////////////////////

// Set initial values for outputs
initial begin 
	result <= 0;
	flags <= 0;
end 

always @(posedge clk)
begin

	case(instruction) 
	
		///////////// ANDS //////////////
		ANDS: begin
			result <= ands_result;
			
			// Update flags
			flags[ZERO] <= (ands_result == 0);
			flags[NEGATIVE] <= ands_result[31];
			flags[CARRY] <= 0;  		// CHECK THIS IN MANUAL!
		end 
		
		///////////// ORRS //////////////
		ORRS: begin
			result <= orrs_result;
			
			// Update flags
			flags[ZERO] <= (orrs_result == 0);
			flags[CARRY] <= 0;      // CHECK IN THE MANUAL!
			flags[NEGATIVE] <= orrs_result[31];
		end
		
		///////////// MVNS //////////////
		MVNS: begin
			result <= mvns_result;
			
			// Update flags
			flags[ZERO] <= (mvns_result == 0);
			flags[NEGATIVE] <= mvns_result[31];
			flags[CARRY] <= 0;  		// CHECK THIS IN MANUAL!
		end
		
		///////////// EORS //////////////
		EORS: begin
			result <= eors_result;
			
			// Update flags
			flags[ZERO] <= (eors_result == 0);
			flags[NEGATIVE] <= eors_result[31];
			flags[CARRY] <= 0;  		// CHECK THIS IN MANUAL!
		end
		
		
		///////////// ADD //////////////
		ADDS: begin
			cin_adder <= 0;
			result <= adder_sum;
			
			// Update flags
			flags[ZERO] <= (adder_sum == 0);
			flags[CARRY] <= cout_adder;
			flags[NEGATIVE] <= adder_sum[31];
		end
		
		/////////// Default ///////////
		default: begin
			result <= 0;
		end 
	endcase
	
end 
	
endmodule
