/*
    Instruction Set

    #####         | ### ### ###         |  ### ### ###         | ### ### ###         |
    OPCODE (5bits)| Destination (9bits) |  Source 1 (5bits)    | Source 2 (9bits)    | 

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
*/


module miniMicro (
    input clk,
    input rst
);

	//Constants

	wire ZERO = 1'b0;	// 0
	wire ONE  = 1'b1;	// 1

    // Instruction Set parameters
    parameter OPCODE_WIDTH = 5;
    parameter DEST_WIDTH = 9;
    parameter SRC1_WIDTH = 9;
    parameter SRC2_WIDTH = 9;

    // wires
    wire [OPCODE_WIDTH-1:0] wire_opcode;  // Opcode	
    wire [DEST_WIDTH-1:0]   wire_rd;      // destination  
    wire [SRC1_WIDTH-1:0]   wire_rs1;     // source 1 
    wire [SRC2_WIDTH-1:0]   wire_rs2;     // source 2

	//progmem wires
    wire [31:0]             wire_instruction;    // 32-bit instruction word recieved from progmem

	//PC wires
	wire [32:0]				wire_progmem_addres; // 32-bit address recieved from PC

	//Alu wires
    wire [31:0]             wire_alu_result;	    // Result from ALU operation
	wire [3:0]				wire_alu_flags;		// negative, ZERO, carry overflow


	/*Instantiate sub modules*/

	//Progam counter
	program_counter PC(.clk(clk),
				       .rst(rst),
					   .pc_out(progmem_addres));


    // RAM modules (one for instruction memory, one for registers)

	//Program (instruction) Memory
	ram_32_read progmem(.wdata(ZERO),
	            .clk(clk),
				.we(ZERO), //Read only
				.address(progmem_addres),
				.rdata(wire_instruction)); //Instruction Memory (read-only)


    //Register Memory
	ram_32_write regmem(.wdata(ONE),
					    .clk(clk),
						.we(ONE), 					//Allow Write 
						.address(progmem_addres),
						.rdata(instruction));   	//Register Memory (read/write)



    // ALU
	ALU alu(.clk(clk), .instruction(wire_instruction) , .num1(wire_rs1), .num2(wire_rs2), .result(wire_alu_result) , .flags(wire_alu_flags))





	always @(posedge clk)
	begin


	/* Check for reset */
	if (rst)
	begin

	end	

	/* IF (instruction fetch): get the instruction at the PC */
		//Get number from program counter
		// fetch instruction form progmem at [idx] (given from programm counter)	


	end

	
	/* ID (instruction decode): decode the instruction, produce control signals and read register file */

	// Divide instruction into its components
	assign wire_opcode = wire_instruction[OPCODE_WIDTH-1:0];
    assign wire_rd     = wire_instruction[OPCODE_WIDTH+DEST_WIDTH-1:OPCODE_WIDTH];
    assign wire_rs1    = wire_instruction[OPCODE_WIDTH+DEST_WIDTH+SRC1_WIDTH-1:OPCODE_WIDTH+DEST_WIDTH];
    assign wire_rs2    = wire_instruction[31:OPCODE_WIDTH+DEST_WIDTH+SRC1_WIDTH];
		

	/* EX (excecute): do calculation */

	/* MEM (memory): access memory */


	/* WB (write back): write back to register */




endmodule


