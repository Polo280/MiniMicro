`timescale 1ns / 1ps

module load_tb();

    // Inputs
    reg clk;
    reg rst;
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
    register_file uut (
        .clk(clk), 
        .rst(rst),
        .A1(A1), 
        .A2(A2), 
        .A3(A3), 
        .WD3(WD3), 
        .R15(R15), 
        .WE3(WE3), 
        .RD1(RD1), 
        .RD2(RD2)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        A1  = 0;
        A2  = 0;
        A3  = 0;
        WD3 = 0;
        R15 = 0;
        WE3 = 0;       

         

        // Wait for the global reset
        #5;
        $display("START: ");

        // Test sequence
        // Write to register 1 (EXPECT 0 BECAUSE WE IS DISABLED)
        A3 = 4'h1;
        WD3 = 32'h12345678;
        #10; // Wait for one clock cycle

        // Write to register 2
        WE3 = 1;
        A3 = 4'h2;
        WD3 = 32'h87654321;
        #10; // Wait for one clock cycle

        // Disable write
        WE3 = 0;

        // Read from register 1
        A1 = 4'h1;
        #10; // Wait for one clock cycle

        // Read from register 2
        A2 = 4'h2;
        #10; // Wait for one clock cycle

        // Test R15 handling
        R15 = 32'h00000010;
        #10; // Wait for one clock cycle

        // Read from register 14 (which is R15 + 8)
        A1 = 4'hE;
        #10; // Wait for one clock cycle

        rst = 1;
        $display("rst enabled: ");
        #1;
        // Finish simulation
        $stop;
    end

    // Generate clock signal
    always #5 clk = ~clk;

    initial begin
        // Monitor the changes
        $monitor("At time %t, clk = %b, Rst = %b,A1 = %h, A2 = %h, A3 = %h, WD3 = %h, R15 = %h, WE3 = %b, RD1 = %h, RD2 = %h", 
                  $time, clk, rst, A1, A2, A3, WD3, R15, WE3, RD1, RD2);
    end
endmodule
