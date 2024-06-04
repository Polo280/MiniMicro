module load_tb();

    // Parameters
    parameter word_size = 32;
    parameter opcode_size = 5;

    reg clk; //gloal clk 
    reg rst; //gloal rst


    //////////////////
    // CONTROL UNIT //
    //////////////////


    // Inputs

    reg [word_size-1:0] CU_in_instruction;
    reg [3:0] flags;

    // Outputs
    wire CU_mem_to_reg;
    wire CU_mem_write;
    wire CU_reg_write;
    wire [opcode_size-1:0] CU_alu_ctrl;
    wire CU_alu_src;
    wire CU_imm_src;

    // Instantiate the Unit Under Test (UUT)
    Control_Unit #(
        .word_size(word_size),
        .opcode_size(opcode_size)
    ) CU_DUT (
        .clk(clk),
        .rst(rst),
        .instruction(CU_in_instruction),
        .flags(flags),
        .mem_to_reg(CU_mem_to_reg),
        .mem_write(CU_mem_write),
        .reg_write(CU_reg_write),
        .alu_ctrl(CU_alu_ctrl),
        .alu_src(CU_alu_src),
        .imm_src(CU_imm_src)
    );
///////////////////////////////////////////////////////////////////



    //////////////////
    ////// RAM ///////
    //////////////////


    parameter DATA_LENGTH = 32;
    parameter MEM_LENGTH = 32;

    // Signals
    reg [DATA_LENGTH-1:0] RAM_wdata;
    reg RAM_we;
    reg [$clog2(MEM_LENGTH)-1:0] RAM_addr;
    wire [31:0] RAM_rdata;

    //WIRE INPUTS
    assign RAM_addr  = CU_in_instruction[26:18];   // r/w destination address(bit 6 to 15 of instruction)
    assign RAM_wdata = CU_in_instruction[17:9];    // Data to write
    assign RAM_we    = CU_mem_write;               // Write Enable flag from CU
     

    // Instantiate the Memory module
    Memory #(
        .data_length(DATA_LENGTH),
        .mem_length(MEM_LENGTH)
    ) RAM_DUT (
        .clk(clk),
        .rst(rst),
        .wdata(RAM_wdata),
        .we(RAM_we),
        .addr(RAM_addr),
        .rdata(RAM_rdata)
    );













    //////////////////
    // REGISTER FILE /
    //////////////////

    reg [8:0]  RF_A1;
    reg [8:0]  RF_A2;
    reg [8:0]  RF_A3;
    reg [8:0]  RF_WD3;
    reg [31:0] RF_R15;
    reg RF_WE3;

    // Outputs
    wire [31:0] RF_RD1;
    wire [31:0] RF_RD2;


    //assign RF_WD3 = RAM_rdata;

    // Instantiate the Unit Under Test (UUT)
    register_file RF_DUT (
        .clk(clk), 
        .rst(rst),
        .A1(CU_in_instruction[26:18]), 
        .A2(RF_A2), 
        .A3(CU_in_instruction[26:18]),  //get addrs from instruction (destination)
        //.WD3(CU_in_instruction[17:9]),  //get data from instruction (operand 1)
        .WD3(RAM_rdata),
        .R15(RF_15), 
        .WE3(CU_reg_write), 
        .RD1(RF_RD1), 
        .RD2(RF_RD2)
    );

/////////////////////////////////////////////////////////////////////////






    ///////////////////////////////////
    //////////// SIMULATION ///////////
    ///////////////////////////////////

    // Initialize Inputs
    initial begin
        clk = 0;
        rst = 1;
        //CU_in_instruction = 32'h00000000; // Default instruction
        flags = 4'b0000;
        RF_WD3 = 0;

        // Apply reset
        #10;
        rst = 0;
        #10

        $display("TEST LOAD:");
        clk = 1;
        //CU_in_instruction <= 32'b10011000000000000000001000000000; // LOAD instruction
        #10;
        CU_in_instruction <= 32'b10011000000000000000001000000000; // LOAD instruction
        $display("cicle 0 ->   reg_write: %b   |    RD1 value: %b     |  inst: %b" , CU_reg_write ,RF_WD3, CU_in_instruction);



        CU_in_instruction <= 32'b10011000000000000000001000000000; // LOAD instruction
        
        #10;
        $display("     TEST MEMORY");


        $display("ram address: %h   |    ram ret data: %b     |  write enable: %b     |      RAM_WDATA: %h \n" , 
                RAM_addr ,RAM_rdata, RAM_we, RAM_wdata);
        $display("Reg input data : %h", RF_WD3);




        //$display("reg_write: %b   |    RD1 value: %b     |  inst: %b     |      RAM_WDATA: %h" , 
        //        CU_reg_write ,RF_A1, CU_in_instruction, RAM_wdata);






        // Finish simulation
        $stop;
    end

    // Generate clock signal
    always
    begin
        #1 clk = ~clk;        
    end

    // Display signals
    initial begin
        
        //$display("reg_write: %b   |    RD1 value: %b     |  inst: %b" , reg_write ,WD3, CU_in_instruction);

    end

endmodule