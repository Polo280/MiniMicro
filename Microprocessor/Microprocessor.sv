// MAIN INSTANCE OF ARM MICROPROCESSOR //

// Reference:
// https://dl.acm.org/doi/pdf/10.5555/2815529
// Pag. 423





module Microprocessor #(parameter word_size = 32)(
	input clk, rst,
	output [word_size-1:0] output_data 
);


//Wire output to output of ALU
	//assign output_data = ALU_result;











////////////////////////////////////////
//////////  PROGRAM COUNTER  ///////////
////////////////////////////////////////

reg [31:0] pc_out;  // Contains the Address of the instruction that must be excecuted


ProgramCounter pc(
	.clk(clk),
	.rst(rst),
	.pc_out(pc_out)
);

////////////////////////////////////////////















////////////////////////////////////////
////////// INSTRUCTION MEMORY //////////
////////////////////////////////////////


parameter instruct_data_length = 32, 
		  instruct_mem_length  = 32;
			 

//INPUTS
reg [$clog2(instruct_mem_length-1):0] instruct_address;	  		// Address bus 

//OUTPUTS
reg [instruct_data_length-1:0]  instruction_mem_return_data;	// contains the actual instruction that must be excecuted


assign instruct_clk = clk;    
assign instruct_address = pc_out; // Address is the output from the PC


instruction_memory Instruction_Memory(
	.return_data(instruction_mem_return_data),
	.address(instruct_address)
);

////////////////////////////////////////















////////////////////////////////////////
///////////// CONTROL UNIT /////////////
////////////////////////////////////////

parameter opcode_size = 5;

// INPUT WIRES
wire ctrl_clk;
wire ctrl_rst;
wire [word_size-1:0] ctrl_instruction; // full 32bit instruction from prog mem
wire [3:0] ctrl_flags;   	 		   // flags recieved from previous ALU operation

// OUTPUT WIRES
wire ctrl_mem_to_reg;            	// Write enable if memory output should be written to registers					
wire ctrl_mem_write;             	//Write enable for
wire ctrl_reg_write;             	// Write enable for Data Memory
wire [opcode_size-1:0] ctr_alu_ctrl; 	//ALU OPCODE



assign ctrl_clk = clk; 
assign ctrl_rst = rst;


assign ctrl_flags = ALU_flags; // assign input flags from alu output flags

// Instruction comes from the output of program memory
assign ctrl_instruction = instruction_mem_return_data;


Control_Unit control_unit(
	.clk(ctrl_clk),
	.rst(ctrl_rst),
	.mem_to_reg(ctrl_mem_to_reg),
	.mem_write(ctrl_mem_write),
	.reg_write(ctrl_reg_write),
	.flags(ctrl_flags),
	.instruction(ctrl_instruction),
	.alu_ctrl(ctrl_alu_ctrl)
);

////////////////////////////////////////














////////////////////////////////////////
///////////// REGISTER FILE ////////////
////////////////////////////////////////

//Reg File Wires and regs


//inputs
wire rf_clk;       //clock
wire rf_WE3;       //write enable
reg [8:0]  rf_A1;  // Addr 1 from Instruction mem
reg [8:0]  rf_A2;  // Addr 2 from Instruction mem
reg [8:0]  rf_A3;  // Addr 3 from Instruction mem
reg [31:0] rf_WD3; // data to write to addr 3 (from output of data memory)
reg [31:0] rf_R15; // current PC value

//outputs
reg[31:0] rf_RD1;  // output data 1 (wired in alu instance) 	
reg[31:0] rf_RD2;  // output data 2 (wired in alu instance)



assign rf_clk = clk; //assign clk from global clk
assign rf_A1 = instruction_mem_return_data[17:9]; // assign address 1 from instruction_memory:output
assign rf_A2 = instruction_mem_return_data[8:0];  // assign address 2 from instruction_memory:output
assign rf_WD3 = datamem_rdata;					  // write back comes from data mem
assign rf_WE3 = ctrl_reg_write;                   // get write enable from ControlUnit:reg_write
assign rf_R15 = pc_out; 						  // assign PC output to R15 input
assign rf_A3  = instruction_mem_return_data[26:18];


register_file RegFile(
	.clk(rf_clk),
	.A1(rf_A1),
	.A2(rf_A2),
	.A3(rf_A3),
	.WD3(rf_WD3),
	.R15(rf_R15),
	.WE3(rf_WE3),
	.RD1(rf_RD1),
	.RD2(rf_RD2)
);

////////////////////////////////////////









////////////////////////////////////////
/////////////// ALU UNIT ///////////////
////////////////////////////////////////

//Inputs
wire[opcode_size-1:0] ALU_instruct; //opcode
reg [word_size-1:0] ALU_num1, ALU_num2;

// Output
wire[3:0] ALU_flags;    
wire [word_size-1:0] ALU_result;


assign ALU_num1 = rf_A1;             // get first num from reg file
assign ALU_num2 = rf_A2;             // get second num from reg file
assign ALU_instruct = ctr_alu_ctrl;  //control recieved from ctrl unit


ALU ALU_Unit(
	.instruction(ctrl_alu_ctrl),
	.num1(ALU_num1),
	.num2(ALU_num2),
	.result(ALU_result),
	.flags(ALU_flags)
);

////////////////////////////////////////














////////////////////////////////////////
///////////// DATA MEMORY //////////////
////////////////////////////////////////

parameter datamem_datalength = 32, 
		  datamem_length     = 32;
			 

//INPUTS
wire datamem_clk;
wire datamem_rst;
wire datamem_we;   			// Reset, clock, write/read enable
reg [datamem_datalength-1:0] datamem_wdata;				// Instruction write data bus 
reg [$clog2(datamem_length -1):0] datamem_address;	    // Address bus 


//OUTPUTS
reg [datamem_datalength-1:0]  datamem_rdata;			// Instruction read data bus 



assign datamem_clk = clk; 								    //assign clk from global clk
assign datamem_rst = rst; 								    //assign rst form global rst
assign datamem_wdata   = ALU_result;                        // Data to write is ALU output
assign datamem_address = instruction_mem_return_data[8:0];  //Assign addrs to store data


assign datamem_we	   = ctrl_mem_write;					//Write enable comes from ctrl unit



Memory Data_Memory(
	.rst(datamem_rst),
	.clk(datamem_clk),
	.we(datamem_we),
	.wdata(datamem_wdata),
	.rdata(datamem_rdata),
	.addr(datamem_address)
);

////////////////////////////////////////






endmodule 