`timescale 1ns/1ps

module Microprocessor_tb;

    // Parameters
    parameter WORD_SIZE = 32;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [WORD_SIZE:0] output_data;

    // Instantiate the Microprocessor module
    Microprocessor #(.word_size(WORD_SIZE)) dut (
        .clk(clk),
        .rst(rst),
        .output_data(output_data)
    );

    // Clock generation
    always #10 clk = ~clk;

    // Testbench initial block
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;

        // Reset the microprocessor
        #10 rst = 0;

        // Test case 1: Load and execute a simple instruction
        // Load ()
        $display("Output Data: %b", output_data);

        // Finish the simulation
        #100 $stop;
    end

endmodule