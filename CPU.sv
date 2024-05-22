/*
*	NAME:
* 		CPU
* 
*	DESCRIPTION:
* 		This module handles the logic of executing an instruction
* 	
* 	PARAMETERS:
* 		
* 	
*
* 	PORTS:
* 		- INPUT:
*					-clk: The clock signal.
*                   -rst: Reset signal.
* 				 	-opcode:      The address input to specify which memory location.
*                   -destination: Memory destination for operation result.
*                   -source_1:    1st operand source.
*                   -source_2:    2nd operand source.
*                   -is_alu_flag: if high, operation requires ALU.
* 		                          
*
* 		- OUTPUTS:
*                	 -
* 	
*/

/*
    Instruction Set

    #####           | ### ### ###         |  ### ### ###       |   ### ### ###       |
    OPCODE (5bits)  | Destination (9bits) |  Source 1 (5bits)  |   Source 2 (9bits)  | 


	RESERVED INSTRUCTIONS 00000, 11001 -> 11111

	// ALU //
    ANDS = 1	  | Bitwise AND
	ORRS = 2	  | Bitwise OR 
	MVNS = 3	  | Bitwise NOT
	EORS = 4	  | Bitwise XOR 
	
	    - Arithmetic operations -

	ADCS = 5	  | Add with carry
	ADDS = 6	  | Normal addition
	SBCS = 7	  | Subtraction with carry
	SUB  = 8	  | Subtraction
	MULS = 9      | Multiplication

	          - Shifts -

	LSRS = 10	  | Logic Shift Right 
	LSLS = 11	  | Logic Shift Left 
	ASR  = 12	  | Arithmetic right shift (arithmetic left is the same as logic left)
	
	        - Rotates- 
	ROR  = 13     | Rotate right 
	
	         - Extends -
	UXTB = 14     | Unsigned extend byte 
	UXTH = 15	  | Unsigned extend halfword 
	SXTB = 16	  | Signed extend byte 
	SXTH = 17	  | Signed extend halfword 
	
	- Other instructions -
	CMP  = 18	  | Compare 
	NOP  = 19     | No Operation
	// ////////////////////////////////// //
	

	(Not ALU instructions)
	// MEMORY INSTRUCTION //
	LOADI = 20 | Load data from RAM to register
	STORE = 21 | Writes data from a register to RAM
	MOV   = 22 | Move data between registers

	// JUMP INSTRUCTIONS //
	J     = 23 | Jump
	BEQ   = 24 | Branch to a mem addr if 2 registers are equal
	HLT   = 24 | HALT

*/


module CPU (
    input clk,
    input rst,
    input [4:0] opcode,     
    input [8:0] destination,
    input [8:0] source_1,
    input [8:0] source_2, 
    input is_alu_flag
);

    wire [31:0] alu_result;
    wire [3:0]  alu_result_flags;

    // Instantiate Modules //

    ALU alu(.clk(clk),
            .global_enable(is_alu_flag),
            .instruction(opcode),
            .num1(source_1),
            .num2(source_2),
            .result(alu_result),
            .flags(alu_result_flags));


    // Registers (ram)


    always @(posedge clk )
    begin
        //Check if current instruction is ALU
        if(!is_alu_flag)
        begin
        //If not alu, handle here (Alu automatically doesn't do anything)
        case (instruction)
            //LOADI
            20:
            //STORE
            21:
            //MOV
            22:
            //Jump
            23:
            //BEQ
            24:
            //HLT
            25: 
            default: 
        endcase

            
        end


    end












endmodule




