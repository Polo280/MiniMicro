module ALU(
	input [4:0] instruction,  // Instruction recieved from program memory
	input [31:0] num1, num2,  // Operands
	output reg [31:0] result, // result of the operation
	output reg [3:0] flags    // Negative, Zero, Carry, oVerflow
);

// Enable wires 
wire[20:0] enable;

////////////////// INSTRUCTION SET //////////////////

parameter // Logic operations
			 ANDS  = 1,			// Bitwise AND
			 ORRS  = 2,			// Bitwise OR 
			 MVNS  = 3,			// Bitwise NOT
			 EORS  = 4,		   // Bitwise XOR 
			 
			 // Arithmetic operations 
			 ADCS  = 5,			// Add with carry
			 ADDS	 = 6,			// Normal addition
			 SBCS  = 7,			// Subtraction with carry
			 SUB   = 8,			// Subtraction
		     MULS  = 9,       // Multiplication

			 // Shifts
			 LSRS  = 10,		// Logic Shift Right 
			 LSLS  = 11,		// Logic Shift Left 
			 ASR = 12,			// Arithmetic right shift (arithmetic left is the same as logic left)
			 
			 // Rotates 
			 ROR   = 13,     	// Rotate right 
			 
			 // Extends
			 UXTB  = 14,  		// Unsigned extend byte 
			 UXTH  = 15,		// Unsigned extend halfword 
			 SXTB  = 16,		// Signed extend byte 
			 SXTH  = 17,		// Signed extend halfword 
			 
			 // Other instructions 
			 CMP   = 18;	   // Compare 
			 
/////////////////////// FLAGS ///////////////////////
parameter    NEGATIVE = 0,
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
	.c_in(cin_adder),
	.num1(num1),
	.num2(num2),
	.sum(adder_sum),
	.c_out(cout_adder)
);

///// Subtractor /////
reg sub_cin; 	
wire cout_sub;
wire [31:0] subt_result;

Subtractor SubtModule(
	.c_in(sub_cin),
	.num1(num1),
	.num2(num2),
	.result(subt_result),
	.c_out(cout_sub)
);

///// MULS /////
wire [63:0] booth_res;

Booth MulMod(
	.M(num1),
	.Q(num2),
	.result(booth_res)
);

///// LSLS /////
wire [31:0] lshift_result;

LSLS LShiftModule(
	.clk(clk),
	.num1(num1),
	.num2(num2),
	.result(lshift_result)
);

///// LSRS /////
wire [31:0] rshift_result;
wire rshift_cout;

LSRS RShiftModule(
	.num(num1),
	.shifts(num2[4:0]),
	.shifted(rshift_result),
	.c_out(rshift_cout)
);

///// ASR /////
wire [31:0] asr_result;
wire asr_carry;

ASR AsrModule(
	.num(num1),
	.shifts(num2[4:0]),
	.shifted(asr_result),
	.c_out(asr_carry)
);

///// ROR /////
wire [31:0] ror_result;

ROR RorModule(
	.num(num1),
	.shifts(num2[4:0]),
	.shifted(ror_result)
);

///// Extend Module /////
reg ext_mode;
reg ext_sign;
wire [31:0] ext_result;

UXTB UxtbModule(
	.mode(ext_mode),
	.sign(ext_sign),
	.num(num1),
	.extended(ext_result)
);

///// Compare Module /////
wire [3:0] cmp_flags;

Comparator Compare(
	.num1(num1),
	.num2(num2),
	.status_flag(cmp_flags)
);

////////////////////// MAIN ALU LOGIC //////////////////////
// Register to store previous flags (to handle carry)
reg [3:0] prev_flags;

initial begin
	result <= 0;
	flags <= 0;
end

// Handle combinational logic 
always @(*)
begin
	case(instruction)
		///////////// ADCS //////////////
		ADCS: begin
			cin_adder = flags[CARRY];
		end
		
		///////////// ADDS //////////////
		ADDS: begin
			cin_adder = 0;
		end
		
		///////////// SBCS //////////////
		SBCS: begin
			sub_cin = flags[CARRY];   // Take the carry as the initial carry in value 
		end
		
		///////////// SUB //////////////
		SUB: begin
			sub_cin = 1;  // This will give us a 1 + one's complement = two's complement for a normal subtraction operation
		end
		
		///////////// UXTB //////////////
		UXTB: begin
			ext_mode = 0;
			ext_sign = 0;
		end
		///////////// UXTH //////////////
		UXTH: begin
			ext_mode = 1;
			ext_sign = 0;
		end
		///////////// SXTB //////////////
		SXTB: begin
			ext_mode = 0;
			ext_sign = 1;
		end
		///////////// SXTH //////////////
		SXTH: begin
			ext_mode = 1;
			ext_sign = 1;
		end
		default: begin
			cin_adder = 0;
			ext_mode = 0;
			ext_sign = 0;
		end
	endcase
end

always @(instruction)
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
		
		///////////// ADCS //////////////
		ADCS: begin
			result <= adder_sum;
			
			// Update flags
			flags[ZERO] <= (adder_sum == 0);
			flags[CARRY] <= cout_adder;
			flags[NEGATIVE] <= adder_sum[31];
		end
		
		///////////// ADD //////////////
		ADDS: begin
			result <= adder_sum;
			
			// Update flags
			flags[ZERO] <= (adder_sum == 0);
			flags[CARRY] <= cout_adder;
			flags[NEGATIVE] <= adder_sum[31];
		end
		
		///////////// SBCS //////////////
		SBCS: begin
			result <= subt_result;
			
			// Update flags
			flags[ZERO] <= (subt_result == 0);
			flags[CARRY] <= cout_sub;
			flags[NEGATIVE] <= subt_result[31];
		end
		
		///////////// SUB //////////////
		SUB: begin
			result <= subt_result;
			
			// Update flags
			flags[ZERO] <= (subt_result == 0);
			flags[CARRY] <= cout_sub;
			flags[NEGATIVE] <= subt_result[31];
		end
		
		///////////// MULS //////////////
		MULS: begin
			result <= booth_res[31:0];
			
			// Update flags
			flags[ZERO] <= (booth_res == 0);
			flags[NEGATIVE] <= booth_res[31];
		end
		
		///////////// LSRS //////////////
		LSRS: begin
			result <= rshift_result;
			
			// Update flags
			flags[ZERO] <= (rshift_result == 0);
			flags[NEGATIVE] <= rshift_result[31];
			flags[CARRY] <= rshift_cout;
		end
		
		///////////// ASR //////////////
		ASR:begin
			result <= asr_result;
			
			// Update flags
			flags[ZERO] <= (asr_result == 0);
			flags[NEGATIVE] <= asr_result[31];
			flags[CARRY] <= asr_carry; 
		end
		
		///////////// ROR //////////////
		ROR:begin
			result <= ror_result;
			
			// Update flags 
			flags[ZERO] <= (ror_result == 0);
			flags[NEGATIVE] <= ror_result[31];
			
			// Put a carry flag
		end
		
		///////////// UXTB //////////////
		UXTB: begin
			result <= ext_result;
			// NO FLAGS
		end
		
		///////////// UXTH //////////////
		UXTH: begin
			result <= ext_result;
			// NO FLAGS
		end
		
		///////////// SXTB //////////////
		SXTB: begin
			result <= ext_result;
			// NO FLAGS
		end
		
		///////////// SXTH //////////////
		SXTH: begin
			result <= ext_result;
			// NO FLAGS
		end
		
		///////////// CMP //////////////
		CMP: begin
			// Update flags but dont store the result of the subtraction
			flags[ZERO] <= cmp_flags[ZERO];
			flags[CARRY] <= 0;
			flags[NEGATIVE] <= cmp_flags[NEGATIVE];
			flags[OVERFLOW] <= cmp_flags[OVERFLOW];
		end 
		
		/////////// Default ///////////
		default: begin
			result <= 0;
		end 
	endcase
end 
	
endmodule