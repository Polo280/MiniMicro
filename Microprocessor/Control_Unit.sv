////////////////////////////////////////
///////////// CONTROL UNIT /////////////
////////////////////////////////////////

module Control_Unit #(parameter word_size = 32, parameter opcode_size = 5)(
	input clk,  						  			// CLK
	input rst,  						   		// RST
	input [word_size-1:0] instruction,     // Instruction recieved from progmem
	input [3:0] flags,  				  		   // flags recieved from previous ALU OP
	
	output reg [word_size-1:0] current_instruct, // Contains the current instruction that must be executed according to 3 stage pipeline 
	output reg [opcode_size-1:0] alu_ctrl, 		// ALU OPCODE
	output reg mem_to_reg,                 		// Write enable if memory output should be written to registers
			     mem_write,                  		// Write enable for Data Memory
			     reg_write,                  		// Write enable for register files -> 0 = dont write, 1 = WRITE

	// optional
	output reg alu_src, imm_src  // Optional implementations for multiplexing
);


////////// INSTRUCTION SET //////////
parameter address_size = 9, addr_chunk = 9;
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
			 CMP   = 18,	    // Compare
			 LDR  = 19,        // LOAD
			 STR = 20, 		    // STORE 
			 MOV   = 21, 		 // MOVE
			 J     = 22, 		 // JUMP
			 BEQ   = 23, 		 // Branch if equal
			 HLT   = 24,		 // HALT
			 NOP   = 25; 		 // No Operation

// Pipeline 		 
reg [word_size-1:0] fetched_instruct;
reg [word_size-1:0] decode_instruct;
reg [word_size-1:0] execute_instruct;

// For decoded data to execute 
reg [opcode_size-1:0] exe_op;
reg [address_size-1:0] exe_dst, exe_src1, exe_src2;


////////////////////////////////////////
////////// INSTRUCTION FETCH ///////////
////////////////////////////////////////

// PIPELINE STRUCTURE 
always @(posedge clk)
begin
	if(rst) begin 
		execute_instruct = 32'b0;
		fetched_instruct = 32'b0;  // Reset variables 
		decode_instruct = 32'b0; 
	end else begin 
		execute_instruct = decode_instruct;
		decode_instruct = fetched_instruct;  // Get previous fetched to decode 
		fetched_instruct = instruction;		 // Fetch new instruction
	end
end 
			 
////////////////////////////////////////
////////// INSTRUCTION DECODE //////////
////////////////////////////////////////

reg [opcode_size-1:0] opcode;
reg [address_size-1:0] destination, src1, src2;

// Get instruction data (DECODE)

always @(posedge clk)  // Will change on clk posedge
begin
	if(rst) begin     // Reset all to 0
		opcode = 0;
		destination = 0;
		src1 = 0;
		src2 = 0;
		exe_op = 0;
		exe_dst = 0;
		exe_src1 = 0;
		exe_src2 = 0;
		// Optional
		alu_src = 1'b0;
		imm_src = 1'b0;
	end else begin 
		// Store previous decode in execute stage
		exe_op = opcode;
		exe_dst = destination;
		exe_src1 = src1;
		exe_src2 = src2;
		// Decode new instruction 
		opcode = decode_instruct[31:27];      // Get opcode (31 - 27)
		destination = decode_instruct[26:18]; // Get destination (26 - 18)
		src1 = decode_instruct[17:9];  	     // Get src1 (17 - 9)
		src2 = decode_instruct[8:0];          // Get src2 (8 - 0)
	end
end

////////////////////////////////////////


////////////////////////////////////////
///////// INSTRUCTION EXECUTE //////////
////////////////////////////////////////

always @(posedge clk) begin
	// on reset
	if(rst) begin
		// Controls 
		current_instruct <= 32'b0;
		alu_ctrl   <= 5'b0;
		mem_write  <= 1'b0;
		mem_to_reg <= 1'b0;
		reg_write  <= 1'b0;
		
	end else begin
		//if op is 0, do nothing
		if(exe_op != 0) begin 
			//check if op must be performed by ALU
			if(exe_op <= 5'b10001) begin   
				// ALU instructions 
				alu_ctrl   <= exe_op;
				mem_write  <= 0;
				mem_to_reg <= 0;
				reg_write  <= 1;
				
			end else begin
				// If operation wont be performed by ALU
				alu_ctrl <= 5'b0;
				// LOAD Management
				if(exe_op == LDR) begin
					mem_to_reg <= 1;
					reg_write <= 1;    // Enable writting from memory to register file 
					mem_write <= 0;
				end else if (exe_op == STR) begin
					// STORE Management
					mem_to_reg <= 1;
					reg_write <= 0;    
					mem_write <= 1;	 // Enable writting to memory from register file 
				end else begin
					mem_write  <= 0;
					mem_to_reg <= 0;
					reg_write  <= 0;
				end 
			end
			
		end else begin  // default values
			alu_ctrl   <= 5'b0;
			mem_write  <= 0;
			mem_to_reg <= 0;
			reg_write  <= 0;
		end  
		current_instruct <= execute_instruct; // Update current instruction
	end
end 

endmodule 