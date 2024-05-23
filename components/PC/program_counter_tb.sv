module program_counter_tb;

  // Inputs
  reg clk;
  reg rst;

  // Outputs
  wire [31:0] pc_out;

  // Instantiate the program counter module
  program_counter pc (
    .clk(clk),
    .rst(rst),
    .pc_out(pc_out)
  );

  // Clock generation
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

   // Test case logic
  initial begin
    // Apply reset for 10 clock cycles
    rst = 1'b1;
    #10 rst = 1'b0;

    // Check PC value after reset
    #10 if (pc_out !== 32'h0) begin
      $display("ERROR: PC not reset to 0 after %d clock cycles", $time);
      $stop;
    end

    // Check PC increment for 20 clock cycles
    for (int i = 0; i < 20; i = i + 1) begin  // Explicit loop bound
      #10;
      if (pc_out !== (32'h0 + i * 4)) begin
        $display("ERROR: PC not incrementing by 4 after %d clock cycles", $time);
        $stop;
      end
    end

    // Success message
    $display("Testbench passed!");
    $finish;
  end

endmodule