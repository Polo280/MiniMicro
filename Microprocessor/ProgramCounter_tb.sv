`timescale 1ns / 1ps

module ProgramCounter_tb();

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    reg [31:0] pc_out;

    // Instantiate the Unit Under Test (UUT)
    ProgramCounter uut (
        .clk(clk), 
        .rst(rst), 
        .pc_out(pc_out)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;

        // Reset the Program Counter
        rst = 1; 
        #10; // Hold reset for 10 time units
        rst = 0;
        
        // Allow the Program Counter to increment
        #100;

        // Finish simulation
        $stop;
    end

    // Generate clock signal
    always #5 clk = ~clk;

    initial begin
        // Monitor the changes
        $monitor("clk = %b, rst = %b, pc_out = %h", clk, rst, pc_out);
    end
endmodule
