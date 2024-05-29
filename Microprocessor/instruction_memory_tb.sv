`timescale 1ns / 1ps

module instruction_memory_tb;

    // Parameters
    parameter DATA_LENGTH = 32;
    parameter MEM_LENGTH  = 32;

    // Inputs
    reg [$clog2(MEM_LENGTH)-1:0] address;

    // Outputs
    wire [DATA_LENGTH-1:0] return_data;

    // Instantiate the Unit Under Test (UUT)
    instruction_memory #(DATA_LENGTH, MEM_LENGTH) uut (
        .address(address), 
        .return_data(return_data)
    );

    initial begin
        // Initialize Inputs
        address = 0;

        // Wait for the global reset
        #5;

        // Add stimulus here
        address = 1;
        #5; // Wait for 5 time units
        
        address = 2;
        #5; // Wait for 5 time units

        address = 3;
        #5; // Wait for 5 time units

        address = 4;
        #5; // Wait for 5 time units

        address = 5;
        #5; // Wait for 5 time units

        address = 30;
        #5; // Wait for 5 time units

        address = 31;
        #5; // Wait for 5 time units
        address = 32;
        #5; // Wait for 5 time units

        // Finish simulation
        $stop;
    end

    initial 
    begin
        // Monitor the changes
        $display("address = %d, return_data = %h", address, return_data);
    end
endmodule