`timescale 1ns / 1ps

module instruction_memory_tb();

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
        $display("Starting test...");

        address = 0;
        #5;

        // Add stimulus here
        address = 1; #5;
        address = 2; #5;
        address = 3; #5;
        address = 4; #5;
        address = 5; #5;
        address = 30; #5;
        address = 31; #5;
        address = 35; #5; // This address is out of range, expect 32'hDEADBEEF

        // Finish simulation
        $stop;
    end


    initial begin
        // Monitor the changes
        $monitor("At time %t: address = %d, return_data = %h", $time, address, return_data);
    end
endmodule