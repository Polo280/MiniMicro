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
	HLT   = 25 | HALT



*/


//TODO: Add enable/disable to ALU

module miniMicro (
    input clk,
    input rst);

	//Constants

	wire ZERO = 1'b0;	// 0
	wire ONE  = 1'b1;	// 1

    // Instruction Set parameters
    parameter OPCODE_WIDTH = 5;
    parameter DEST_WIDTH   = 9;
    parameter SRC1_WIDTH   = 9;
    parameter SRC2_WIDTH   = 9;

    // wires
    wire [OPCODE_WIDTH-1:0] wire_opcode;  // Opcode	
    wire [DEST_WIDTH-1:0]   wire_dest;      // destination  
    wire [SRC1_WIDTH-1:0]   wire_rs1;     // source 1 
    wire [SRC2_WIDTH-1:0]   wire_rs2;     // source 2

	//progmem wires
    wire [31:0]             wire_instruction;    // 32-bit instruction word recieved from progmem

	//PC wires
	wire [32:0]				wire_progmem_addres; // 32-bit address recieved from PC

	//Alu wires
    wire [31:0]             wire_alu_result;	 // Result from ALU operation
	wire [3:0]				wire_alu_flags;		 // negative, ZERO, carry overflow
	wire 					wire_alu_enable;     //


	/*Instantiate sub modules*/

	//Progam counter
	program_counter PC(.clk(clk),
				       .rst(rst),
					   .pc_out(wire_progmem_addres));


    // RAM modules (one for instruction memory, one for registers)

	//Program (instruction) Memory
	ram_32_read progmem(.wdata(ZERO),
	            .clk(clk),
				.we(ZERO), //Read only
				.address(wire_progmem_addres),
				.rdata(wire_instruction)); //Instruction Memory (read-only)


    //Register Memory
	ram_32_write regmem(.wdata(ONE),
					    .clk(clk),
						.we(ONE), 					//Allow Write 
						.address(wire_progmem_addres),
						.rdata(wire_instruction));   	//Register Memory (read/write)



    // ALU
	ALU alu(.clk(clk), 
		    .instruction(wire_opcode),
			.num1(wire_rs1),
			.num2(wire_rs2),
			.result(wire_alu_result),
			.flags(wire_alu_flags))





	always @(posedge clk)
	begin


		/* Check for reset */
		if (rst)
		begin
			wire_progmem_addres = 0; // reset PC to 0
			//handle reset logic (most modules handle their own reset logic)
		end	




		/* IF (instruction fetch): get the instruction at the PC */
			/*  - Automatically done by PC 
				- PC returns progmem address (wire_progmem_address)
				- Addr is wired to progmem, it returns the instruction and storest it on wire_instruction
			
			*/


		
		/* ID (instruction decode): decode the instruction, produce control signals and read register file */

		// Divide instruction into its components
		assign wire_opcode = wire_instruction[OPCODE_WIDTH-1:0]; // OPCODE
		assign wire_dest   = wire_instruction[OPCODE_WIDTH+DEST_WIDTH-1:OPCODE_WIDTH]; // Destination
		assign wire_rs1    = wire_instruction[OPCODE_WIDTH+DEST_WIDTH+SRC1_WIDTH-1:OPCODE_WIDTH+DEST_WIDTH];  // Source 1
		assign wire_rs2    = wire_instruction[31:OPCODE_WIDTH+DEST_WIDTH+SRC1_WIDTH]; // Source 2


		
			

		/* EX (excecute): do calculation */

		//Check if operation is ALU or not
		if( ! ((wire_opcode > 5'b00000) && (wire_opcode < 5'b11001)))
		begin
			//operation IS NOT ALU

			//todo: Disable ALU


			case (wire_opcode)
				
				20: 
				begin
					//LOADI
				end
				21: 
				begin
					//STORE
				end
				22: 
				begin
					//MOV
				end
				23: 
				begin
					//J (jump)
				end
				24: 
				begin
					//BEQ
				end 
				25: 
				begin
					//HLT
				end  
			endcase
		end

		else // if instruction is ALU
		begin
			//todo: enable alu and Wire
		end

 

		/* MEM (memory): access memory */


		/* WB (write back): write back to register */


	end
endmodule


