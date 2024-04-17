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

initial 
	begin
		clock = 0;
		instruction = 0;
		num1 = 0;
		num2 = 0;
		#2
		instruction = 1;     // ANDS test
		num1 = 15;
		num2 = 10;
		#2 
		instruction = 2;     // ORRS test
		num1 = 500;
		num2 = 5;
		#2 
		instruction = 3;     // Bitwise not (MVNS) test
		num1 = 4294967200;
		#2
		instruction = 4;     // EORS test
		num1 = 295;
		num2 = 426;
		#2
		instruction = 7;     // ADDS test
		num1 = 9;
		num2 = 1;
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
