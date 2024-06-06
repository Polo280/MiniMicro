module InstructionMemory # (parameter data_length = 32, parameter mem_length = 64)(
input clk,												// Clock to synchronize 	
input rst,  											// Reset block to start with initial known values 
input [data_length-1:0] wdata, 					// Data to be written into memory (Write data bus)
input we, 												// Read - write mode : 0 = READ, 1 = WRITE
input [$clog2(mem_length)-1:0] addr, 			// Address bus

output reg [data_length-1:0] rdata 				// Read(return) data bus 
);

// 32 different memory locations 
// 9 bits for identifying each location 
// 5 bit instructions 


// CREATION OF MEMORY CELLS
reg [data_length-1:0] instructs [mem_length-1:0];

// Inside Logic
always @(posedge clk) 
begin
	if(rst) begin
		// Set random instructions to test
						   // opcode  mem addr  ignore    reg 
		instructs[0] = 32'b10011_000000000_000000001_000000000; // LOAD instruction (save mem 0 in reg 0)
		instructs[1] = 32'b10011_000000001_000000001_000000001; // LOAD instruction (save mem 1 in reg 1)
		instructs[2] = 32'b10011_000000010_000000001_000000001; // LOAD instruction (save mem 1 in reg 1)
		instructs[3] = 32'b10011_000000011_000000001_000000001; // LOAD instruction (save mem 1 in reg 1)
		instructs[4] = 32'b00110_000000000_000000001_000000010; // ADD instruction reg0 + reg1 (save in reg 2)
		instructs[5] = 32'b00110_000000001_000000010_000000010; // ADD instruction reg1 + reg2 (save in reg 3)
		instructs[6] = 32'b00000_000000000_000000000_000000000; // Zeros to avoid undefined behavior 
		instructs[7] = 32'b00000_000000000_000000000_000000000; 
		instructs[8] = 32'b00000_000000000_000000000_000000000; 
		instructs[9] = 32'b00000_000000000_000000000_000000000; 
		instructs[10] = 32'b00000_000000000_000000000_000000000; 
		instructs[11] = 32'b00000_000000000_000000000_000000000; 
		instructs[12] = 32'b00000_000000000_000000000_000000000; 
		instructs[13] = 32'b00000_000000000_000000000_000000000; 
		instructs[14] = 32'b00000_000000000_000000000_000000000; 
		instructs[15] = 32'b00000_000000000_000000000_000000000; 
		rdata = 0;   // Reset rdata bus
	end else begin
		rdata = instructs[addr];
	end
end

endmodule 
