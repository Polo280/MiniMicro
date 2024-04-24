`timescale 1ns / 1ns

module ALU_tb();

reg clock;
reg[4:0] instruction;
reg [31:0] num1, num2;
wire [31:0] result;
wire [3:0] flags;

ALU ALU_Mod(
	.clk(clock),
	.instruction(instruction),
	.num1(num1),
	.num2(num2),
	.result(result),
	.flags(flags)
);

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
			 ASR = 12,        // Arithmetic right shift 
			 
			 // Rotates 
			 ROR   = 13,     	// Rotate right 
			 
			 // Extends
			 UXTB  = 14,  		// Unsigned extend byte 
			 UXTH  = 15,		// Unsigned extend halfword 
			 SXTB  = 16,		// Signed extend byte 
			 SXTH  = 17,		// Signed extend halfword 
			 
			 // Other instructions 
			 CMP   = 18;	   // Compare 
			 
initial 
	begin
		clock = 0;
		instruction = 0;
		num1 = 0;
		num2 = 0;
		#2
		instruction = ANDS;     // ANDS test
		num1 = 15;
		num2 = 10;
		#2 
		instruction = ORRS;     // ORRS test
		num1 = 500;
		num2 = 5;
		#2 
		instruction = MVNS;     // Bitwise not (MVNS) test
		num1 = 4294967200;
		#2
		instruction = EORS;     // EORS test
		num1 = 295;
		num2 = 426;
		#2
		instruction = ADDS;     // ADDS test
		num1 = 9;
		num2 = 1;
		#2 
		instruction = SUB;      // SUB test
		num1 = 16;
		num2 = 4;
		#2 
		instruction = LSLS;     // LSLS test
		num1 = 32'b1101;
		num2 = 3;
		#2 
		instruction = LSRS;     // LSRS test
		num1 = 32'b1101;
		num2 = 3;
		#2 
		instruction = ASR;      // ASR test
		num1 = 205;
		num2 = 3;
		#2 
		instruction = UXTB;      // UXTB test
		num1 = 490;
		#2 
		instruction = UXTH;      // UXTH test
		num1 = 56623;
		#2 
		instruction = SXTB;      // SXTB test
		num1 = 5950485;
		#2 
		instruction = SXTH;      // SXTB test
		num1 = 5950485;
		#2 
		instruction = 0;
		$Stop;
	end

always
	begin
		#1
		clock = ~clock;
	end

endmodule
