////////////////////////////////////////
///////////// CONTROL UNIT /////////////
////////////////////////////////////////
`timescale 1ns / 1ps

module Control_Unit_tb();

    // Parameters
    parameter word_size = 32;
    parameter opcode_size = 5;

    // Inputs
    reg clk;
    reg rst;
    reg [word_size-1:0] instruction;
    reg [3:0] flags;

    // Outputs
    wire mem_to_reg;
    wire mem_write;
    wire reg_write;
    wire [opcode_size-1:0] alu_ctrl;
    wire alu_src;
    wire imm_src;

    // Instantiate the Unit Under Test (UUT)
    Control_Unit #(
        .word_size(word_size),
        .opcode_size(opcode_size)
    ) uut (
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .flags(flags),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .alu_ctrl(alu_ctrl),
        .alu_src(alu_src),
        .imm_src(imm_src)
    );

    // Initialize Inputs
    initial begin
        clk = 1;
        rst = 1;
        instruction = 32'h00000000; // Default instruction
        flags = 4'b0000;

        // Apply reset
        #2
        rst = 0;
        // Test Memory instruction (LOAD)
        $display("              TEST LOAD");
        instruction = 32'b10011_000000000_000000001_000000000; // LOAD instruction (save mem 0 in reg 0)
        #2

        // Test ALU instruction (ADD)             TEST ADD");
        instruction = 32'b10011_000000001_000000001_000000001; // LOAD instruction (save mem 1 in reg 1)
        #2
		  
		  instruction = 32'b00110_000000000_000000001_000000010; // ADD instruction reg0 + reg1 (save in reg 2)
		  #2 
		  
		  instruction = 32'b10011_000000000_000000001_000000000; // ADD instruction reg1 + reg2 (save in reg 3)
		  #2

        // Test default instruction (NOP)
        $display("              TEST ALL 0's");
        instruction = 32'b0; // NOP instruction
        #2

        // Finish simulation
        $Stop;
    end

    // Generate clock signal
    always #1 clk = ~clk;

    // Display signals
    initial begin
        $monitor("At time %t: clk=%b, rst=%b, instruction=%b, flags=%b, mem_to_reg=%b, mem_write=%b, reg_write=%b, alu_ctrl=%b, alu_src=%b, imm_src=%b",
            $time, clk, rst, instruction, flags, mem_to_reg, mem_write, reg_write, alu_ctrl, alu_src, imm_src);
    end

endmodule