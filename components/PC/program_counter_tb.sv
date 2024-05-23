`timescale 1ns / 1ps

module program_counter_tb(
    input clk,
    input rst,
    output [31:0] pc_out
);


    // Instantiate the program_counter module
    program_counter uut (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 ns (100 MHz clock period)
    end

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;

        // Monitor the pc_out output
        $monitor("Time = %0d, pc_out = %h", $time, pc_out);

        // Reset the program counter
        rst = 1; #10; // Assert reset for 10 ns
        rst = 0; #10; // Deassert reset and wait for 10 ns

        // Run the clock for a few cycles to see the PC increment
        #100; // Let the clock run for 100 ns
        
        // End simulation
        $stop;
    end

endmodule
