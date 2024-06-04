/* `timescale 1ns/1ps

module Memory_tb;
    // Parameters
    parameter DATA_LENGTH = 32;
    parameter MEM_LENGTH = 32;

    // Signals
    reg clk;
    reg rst;
    reg [DATA_LENGTH-1:0] wdata;
    reg we;
    reg [$clog2(MEM_LENGTH)-1:0] addr;
    wire [DATA_LENGTH-1:0] rdata;

    // Instantiate the Memory module
    Memory #(
        .data_length(DATA_LENGTH),
        .mem_length(MEM_LENGTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .wdata(wdata),
        .we(we),
        .addr(addr),
        .rdata(rdata)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        wdata = 0;
        we = 0;
        addr = 0;

        // Reset the module
        @(posedge clk);
        rst = 0;

        // Test write operation
        @(posedge clk);
        we = 1;
        wdata = 32'h12345678;
        addr = 0;
        @(posedge clk);
        we = 0;

        // Test read operation
        @(posedge clk);
        addr = 0;
        @(posedge clk);
        $display("Read data: %h", rdata);

        // Test multiple write and read operations
        for (int i = 1; i < MEM_LENGTH; i++) begin
            @(posedge clk);
            we = 1;
            wdata = $random;
            addr = i;
            @(posedge clk);
            we = 0;
            addr = i;
            @(posedge clk);
            $display("Read data at address %d: %h", i, rdata);
        end

        $stop;
    end

endmodule */



`timescale 1ns/1ps

module Memory_tb;
    // Parameters
    parameter DATA_LENGTH = 32;
    parameter MEM_LENGTH = 32;

    // Signals
    reg clk;
    reg rst;
    reg [DATA_LENGTH-1:0] wdata;
    reg we;
    reg [$clog2(MEM_LENGTH)-1:0] addr;
    wire [DATA_LENGTH-1:0] rdata;

    // Instantiate the Memory module
    Memory #(
        .data_length(DATA_LENGTH),
        .mem_length(MEM_LENGTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .wdata(wdata),
        .we(we),
        .addr(addr),
        .rdata(rdata)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        wdata = 0;
        we = 0;
        addr = 0;

        // Reset the module
        @(posedge clk);
        rst = 0;

        // Wait for the reset to complete
        @(posedge clk);

        // Read and display all memory contents
        for (int i = 0; i < MEM_LENGTH; i++) begin
            @(posedge clk);
            addr = i;
            @(posedge clk);
            $display("Read data at address %d: %h", i, rdata);
        end

        $stop;
    end


endmodule