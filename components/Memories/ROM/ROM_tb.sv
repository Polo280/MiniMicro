module ROM_tb;

parameter DATA_LENGTH = 32;
parameter MEM_LENGTH = 32;

  // DUT (Device Under Test) signals
  reg clk, address;
  wire [DATA_LENGTH-1:0] return_data;

  // Memory for testing (instead of accessing dut.mem)
  reg [DATA_LENGTH-1:0] mem [MEM_LENGTH-1:0];

  // DUT instantiation
  ROM #( .DATA_LENGTH(DATA_LENGTH), .MEM_LENGTH(MEM_LENGTH)) 
    dut (
         .clk(clk),
         .address(address),
         .return_data(return_data)
    );

  // Clock generation
  initial begin
    clk = 1'b0;
    repeat (10) @(posedge clk); // Generate 10 clock cycles
  end

  // Test loop (one pass through all addresses) with specific values
  initial begin
    integer i;
    for (i = 0; i < MEM_LENGTH; i = i + 1) begin
      mem[i] = i; // Assign specific values (0 to MEM_LENGTH-1)
      address = i;
      @(posedge clk); // Wait for next clock cycle
      // No need to explicitly check data here (keeps it simple)
    end
    $stop;
  end

endmodule
