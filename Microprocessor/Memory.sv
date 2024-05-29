module Memory # (parameter data_length = 32, parameter mem_length = 32)(
input clk,										// Clock to syncrhonize 	
input rst,  									// Reset block to start with initial known values 
input [data_length-1:0] wdata, 					// Data to be written into memory (Write data bus)
input we, 										// Read - write mode : 0 = READ, 1 = WRITE
input [$clog2(mem_length)-1:0] addr, 			// Address bus

output reg [data_length-1:0] rdata 				// Read data bus 
);

// 32 different memory locations 
// 9 bits for identifying each location 
// 5 bit instructions 


//create actual memory
reg [data_length-1:0] mem [0:mem_length-1];


always @(posedge clk or posedge rst)
begin 
	// Manage initial conditions 
	if(rst) begin
		int i;
		for (i = 0 ; i <= 0; i = i+1)
		begin
			mem[i] <= 0;
		end
	end else 
	begin 
		// Identify read or write mode 
		if(we)
		begin
			mem[addr] <= wdata;  // Update internal storage cell with the write data bus value
		end
		else
			rdata <= mem[addr];	// Update read data bus output with data stored in address cell 
		end 
	end
endmodule 