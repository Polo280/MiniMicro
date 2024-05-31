module load_tb();

    // Parameters
    parameter word_size = 32;
    parameter opcode_size = 5;

    reg clk;
    reg rst;


    //////////////////
    // CONTROL UNIT //
    //////////////////


    // Inputs

    reg [word_size-1:0] CU_in_instruction;
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
    ) CU_DUT (
        .clk(clk),
        .rst(rst),
        .instruction(CU_in_instruction),
        .flags(flags),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .alu_ctrl(alu_ctrl),
        .alu_src(alu_src),
        .imm_src(imm_src)
    );



    //////////////////
    // REGISTER FILE /
    //////////////////

    reg [8:0] A1;
    reg [8:0] A2;
    reg [8:0] A3;
    reg [31:0] WD3;
    reg [31:0] R15;
    reg WE3;

    // Outputs
    wire [31:0] RD1;
    wire [31:0] RD2;

    // Instantiate the Unit Under Test (UUT)
    register_file RF_DUT (
        .clk(clk), 
        .rst(rst),
        .A1(CU_in_instruction[26:18]), 
        .A2(A2), 
        .A3(CU_in_instruction[26:18]),  //get addrs from instruction (destination)
        .WD3(CU_in_instruction[17:9]),  //get data from instruction (operand 1)
        .R15(R15), 
        .WE3(reg_write), 
        .RD1(RD1), 
        .RD2(RD2)
    );







    // Initialize Inputs
    initial begin
        clk = 0;
        rst = 1;
        CU_in_instruction = 32'h00000000; // Default instruction
        flags = 4'b0000;

        // Apply reset
        #10;
        rst = 0;
        #10

        $display("TEST LOAD:");
        CU_in_instruction = 32'b10011000000000000000001000000000; // LOAD instruction
        #10;






        // Finish simulation
        $stop;
    end

    // Generate clock signal
    always #5 clk = ~clk;

    // Display signals
    initial begin
        
        $monitor("RD1 value: %b" , WD3);

    end

endmodule