//////////// PROGRAM COUNTER ///////////

// Brief: Program Counter determines which instrucion will be executed in current cycle. 

module ProgramCounter (
    input clk, pc, rst, en,
    output reg [5:0] pc_out
);   

reg [5:0] pc_aux;

// Synchronous module 
always @(posedge clk) begin
  if (rst) begin
		pc_aux = 4'b0;
		pc_out = 4'b0;       // Reset PC to initial address
  end 
  else begin
		if(en) begin        // Only modify program counter if enabled 
			pc_aux = pc_out; 
			pc_out = pc_aux + 1; // Increment PC by instruction width (32-bit)
		end else begin
			pc_out = pc_out;
		end
  end
end
endmodule
