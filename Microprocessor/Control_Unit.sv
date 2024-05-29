module Control_Unit #(parameter word_size = 32, parameter opcode_size = 5)(
	input clk,  						   //CLK
	input rst,  						   //RST
	input [word_size-1:0] instruction,     // Instruction recieved from progmem
	input [3:0] flags,  				   // flags recieved from previous ALU OP
	
	output reg mem_to_reg,                 // Write enable if memory output should be written to registers
			   mem_write,                  // Write enable for Data Memory
			   reg_write,                  // Write enable for register files -> 0 = dont write, 1 = WRITE
	output reg [opcode_size-1:0] alu_ctrl,

	//optional
	output reg alu_src, imm_src  // Optional implementations for multiplexing
);

////////// INSTRUCTION SET //////////
parameter // Logic operations
			 ANDS  = 1,			// Bitwise AND
			 ORRS  = 2,			// Bitwise OR 
			 MVNS  = 3,			// Bitwise NOT
			 EORS  = 4,		    // Bitwise XOR 
			 
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
			 CMP   = 18,	   // Compare
			 NOP   = 5'b10010, // No Operation
			 LOAD  = 5'b10011, // LOAD
			 STORE = 5'b10100, // STORE 
			 MOV   = 5'b10101, // MOVE
			 J     = 5'b10110, // JUMP
			 BEQ   = 5'b10111, // Branch if equal
			 HLT   = 5'b11000; // HALT

////////////////////////////////////////
////////// INSTRUCTION DECODE //////////
////////////////////////////////////////
parameter address_size = 9, addr_chunk = 9;

reg [opcode_size-1:0] opcode;
reg [address_size-1:0] destination, src1, src2;

// Get instruction data (DECODE)

always @(instruction) 
begin
	opcode = instruction[31:27];      // Get opcode (31 - 27)
	destination = instruction[26:18]; // Get destination (26 - 18)
	src1 = instruction[17:9];  	      // Get src1 (17 - 9)
	src2 = instruction[8:0];          // Get src2 (8 - 0)
end

////////////////////////////////////////



////////////////////////////////////////
//////// INSTRUCTION PROCESSING ////////
////////////////////////////////////////

always @(*) begin

	//on reset:
	if(rst) 
	begin
		alu_ctrl   = 5'b0;
		mem_write  = 0;
		mem_to_reg = 0;
		reg_write  = 0;
	end 
	else 

	begin

		//if op is 0, do nothing
		if(opcode != 0) 
		begin 

			//check if op must be performed by ALU
			if(opcode <= 5'b10001) 
			begin   
				// ALU instructions 
				alu_ctrl   = opcode;
				mem_write  = 1;
				mem_to_reg = 1;
				reg_write  = 1;
			end 
			else 
				begin 
					alu_ctrl = 5'b0;
					// Memory/additional instructions 
					if(opcode == LOAD || opcode == MOV) 
					begin
						mem_write  = 0;  // Disable Writing to data memory
						mem_to_reg = 1;  // Enable writing to registers
						reg_write  = 1;  // Write enable to registers						 
					end 
					else if(opcode == STORE)
					begin 
						mem_write = 1;  // write data 
					end 
					else //default 
					begin
						mem_write = 0;  // Set default to read 
					end
				end 
		end 
		else 
		begin  // default values
			alu_ctrl   = 5'b0;
			mem_write  = 0;
			mem_to_reg = 0;
			reg_write  = 0;
		end 
	end
end 

endmodule 