module Control_Unit #(parameter word_size = 32, parameter opcode_size = 5)(
	input clk, rst,
	input [word_size-1:0] instruction,
	input [3:0] flags,
	output reg mem_to_reg, mem_write, reg_write,   // MemWrite -> 0 = write, 1 = read
	output reg [opcode_size-1:0] alu_ctrl,
	output reg alu_src, imm_src  // Optional implementations for multiplexing
);

////////// INSTRUCTION SET //////////
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
			 CMP   = 18,	   // Compare
			 NOP   = 5'b10010,
			 LOAD  = 5'b10011,
			 STORE = 5'b10100,
			 MOV   = 5'b10101,
			 J     = 5'b10110,
			 BEQ   = 5'b10111,
			 HLT   = 5'b11000;

////////////////////////////////////////
////////// INSTRUCTION DECODE //////////
////////////////////////////////////////
parameter address_size = 6, addr_chunk = 9;

reg [opcode_size-1:0] opcode;
reg [address_size-1:0] destination, src1, src2;

// Get instruction data (DECODE)
always @(*) begin
	opcode = instruction[word_size-1:word_size - opcode_size];   // Get opcode (31 - 27)
	destination = instruction[(word_size-1)-opcode_size : word_size -opcode_size -addr_chunk];  				 // Get destination (26 - 18)
	src1 = instruction[(word_size-1)-opcode_size-addr_chunk : word_size -opcode_size - 2*addr_chunk];  	 // Get src1 (17 - 9)
	src2 = instruction[(word_size-1)-opcode_size - 2*addr_chunk : word_size - opcode_size - 3*addr_chunk]; // Get src2 (8 - 0)
end
////////////////////////////////////////

////////////////////////////////////////
//////// INSTRUCTION PROCESSING ////////
////////////////////////////////////////

always @(posedge clk or posedge rst) begin
	if(rst) begin
		alu_ctrl <= 5'b0;
		mem_write <= 1;
		mem_to_reg <= 0;
		reg_write <= 0;
	end else begin
		if(opcode != 0) begin 
			if(opcode < 5'b10001) begin   // ALU instructions 
				alu_ctrl <= opcode;
			end else begin // Memory/additional instructions 
				if(opcode == LOAD || opcode == MOV) begin
					mem_write <= 1;  // read data 
				end else if(opcode == STORE) begin 
					mem_write <= 0;  // write data 
				end else begin
					mem_write <= 1;  // Set default to read 
				end
			end 
		end else begin  // default values
			alu_ctrl <= 5'b0;
			mem_write <= 1;
			mem_to_reg <= 0;
			reg_write <= 0;
		end 
	end
end 

endmodule 