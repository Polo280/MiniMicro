// MAIN INSTANCE OF ARM MICROPROCESSOR //

module Microprocessor #(parameter word_size = 32)(
	input clk, rst,
	output [word_size-1:0] output_data 
);

////////////////////////////////////////
////////// INSTRUCTION MEMORY //////////
////////////////////////////////////////

// NOTE: Data cannot be written to this memory, so it has only an address and a rdata bus 

parameter instruct_data_length = 8, 
			 instruct_mem_length  = 64;
			 
wire instruct_rst, instruct_clk, instruct_we;   			  // Reset, clock, write/read enable
reg [$clog2(instruct_mem_length-1):0] instruct_address;	  // Address bus 
reg [instruct_data_length-1:0] instruct_wdata;				  // Instruction write data bus 
reg [instruct_data_length-1:0]  instruct_rdata;				  // Instruction read data bus 

assign instruct_clk = clk;
assign instruct_rst = rst;
assign instruct_we = 1'b1;  // Read mode

Memory Instruction_Memory(
	.rst(instruct_rst),
	.clk(instruct_clk),
	.we(instruct_we),
	.wdata(instruct_wdata),
	.rdata(instruct_rdata),
	.addr(instruct_address)
);
////////////////////////////////////////

////////////////////////////////////////
///////////// DATA MEMORY //////////////
////////////////////////////////////////
parameter datamem_datalength = 8, 
			 datamem_length  = 64;
			 
wire datamem_rst, datamem_clk, datamem_we;   			  // Reset, clock, write/read enable
reg [$clog2(datamem_length -1):0] datamem_address;	     // Address bus 
reg [datamem_datalength-1:0] datamem_wdata;				  // Instruction write data bus 
reg [datamem_datalength-1:0]  datamem_rdata;				  // Instruction read data bus 

assign datamem_clk = clk;
assign datamem_rst = rst;

Memory Data_Memory(
	.rst(datamem_rst),
	.clk(datamem_clk),
	.we(datamem_we),
	.wdata(datamem_wdata),
	.rdata(datamem_rdata),
	.addr(datamem_address)
);
////////////////////////////////////////

////////////////////////////////////////
///////////// CONTROL UNIT /////////////
////////////////////////////////////////
parameter opcode_size = 5;

wire ctrl_clk, ctrl_rst, mem_to_reg, mem_write, reg_write;
wire [opcode_size-1:0] alu_ctrl;
wire [word_size-1:0] ctrl_instruction;
wire [3:0] flags;

assign ctrl_clk = clk;
assign ctrl_rst = rst;

Control_Unit(
	.clk(ctrl_clk),
	.rst(ctrl_rst),
	.mem_to_reg(mem_to_reg),
	.mem_write(mem_write),
	.reg_write(reg_write),
	.flags(flags),
	.instruction(ctrl_instruction),
	.alu_ctrl(alu_ctrl)
);

////////////////////////////////////////

////////////////////////////////////////
/////////////// ALU UNIT ///////////////
////////////////////////////////////////
wire ALU_clk;
wire[opcode_size-1:0] ALU_instruct;
wire[3:0] ALU_flags;   // Output 
reg [word_size-1:0] ALU_num1, ALU_num2;
wire [word_size-1:0] ALU_result;

assign ALU_clk = clk;

ALU ALU_Unit(
	.clk(ALU_clk),
	.instruction(ALU_instruct),
	.num1(ALU_num1),
	.num2(ALU_num2),
	.flags(ALU_flags)
);

////////////////////////////////////////


endmodule 